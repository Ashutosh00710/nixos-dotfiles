// MCP keep-alive: briefly starts every OAuth `mcp-remote` bridge configured in
// OpenClaw, which refreshes its tokens, and DMs the owner on Slack (via the
// OpenClaw Slack bot) when a bridge needs an interactive re-sign-in.
//
// Bridges are read from ~/.openclaw/openclaw.json (mcp.servers), and started
// with exactly OpenClaw's command, args and env, so tokens are read from and
// written to the same ~/.mcp-auth entries OpenClaw uses.
//
// Usage: node keepalive.mjs [--dry-run] [--test-alert]
import { spawn } from "node:child_process";
import { readFileSync, writeFileSync, mkdirSync } from "node:fs";
import { homedir } from "node:os";
import { join } from "node:path";

const HOME = homedir();
const SLACK_USER = process.env.MCP_KEEPALIVE_SLACK_USER ?? "U05QXM7DZDJ";
const STATE_DIR = join(process.env.XDG_STATE_HOME ?? join(HOME, ".local/state"), "mcp-keepalive");
const STATE_FILE = join(STATE_DIR, "state.json");
const TIMEOUT_MS = 60_000;
const REMIND_MS = 24 * 3600_000;
const ERRORS_BEFORE_ALERT = 2; // network blips should not page; auth problems alert at once
const DRY_RUN = process.argv.includes("--dry-run");

const openclaw = JSON.parse(readFileSync(join(HOME, ".openclaw/openclaw.json"), "utf8"));
const botToken = openclaw.channels?.slack?.botToken;

// OAuth bridges: stdio servers that run mcp-remote. Each needs a fixed callback
// port (the last numeric arg) for the SSH-tunnelled re-sign-in.
const bridges = Object.entries(openclaw.mcp?.servers ?? {})
  .filter(([, s]) => s.command && (s.args ?? []).some((a) => a.includes("mcp-remote")))
  .map(([name, s]) => ({
    name,
    command: s.command,
    args: s.args ?? [],
    env: s.env ?? {},
    url: (s.args ?? []).find((a) => /^https?:\/\//.test(a)),
    port: [...(s.args ?? [])].reverse().find((a) => /^\d{4,5}$/.test(a)),
  }));

const INIT = JSON.stringify({
  jsonrpc: "2.0", id: 1, method: "initialize",
  params: { protocolVersion: "2025-06-18", capabilities: {}, clientInfo: { name: "mcp-keepalive", version: "1" } },
});

// Starts a bridge and waits for its initialize reply. Returns "ok", "needs_auth" or "error".
function check(bridge) {
  return new Promise((resolve) => {
    const child = spawn(bridge.command, bridge.args, {
      env: { ...process.env, ...bridge.env },
      stdio: ["pipe", "pipe", "pipe"],
      detached: true,
    });
    let out = "", err = "", done = false;
    const finish = (status, detail) => {
      if (done) return;
      done = true;
      clearTimeout(timer);
      try { process.kill(-child.pid, "SIGTERM"); } catch {}
      resolve({ status, detail });
    };
    const timer = setTimeout(() => finish("error", "no initialize reply within 60s"), TIMEOUT_MS);
    child.stdout.on("data", (d) => {
      out += d;
      for (const line of out.split("\n")) {
        try { if (JSON.parse(line).id === 1) return finish("ok", "initialized"); } catch {}
      }
    });
    child.stderr.on("data", (d) => {
      err += d;
      if (/Please authorize this client|Authentication required/i.test(err)) finish("needs_auth", "sign-in required");
    });
    child.on("exit", (code) => finish("error", `bridge exited (${code}): ${err.trim().split("\n").pop() ?? ""}`));
    child.stdin.write(INIT + "\n");
  });
}

async function slack(method, body) {
  if (!botToken) throw new Error("no channels.slack.botToken in OpenClaw config");
  const res = await fetch(`https://slack.com/api/${method}`, {
    method: "POST",
    headers: { authorization: `Bearer ${botToken}`, "content-type": "application/json; charset=utf-8" },
    body: JSON.stringify(body),
    signal: AbortSignal.timeout(15_000),
  });
  const json = await res.json();
  if (!json.ok) throw new Error(`${method}: ${json.error}`);
  return json;
}

async function dm(text) {
  if (DRY_RUN) { console.log(`[dry-run] DM ${SLACK_USER}:\n${text}\n`); return; }
  const { channel } = await slack("conversations.open", { users: SLACK_USER });
  await slack("chat.postMessage", { channel: channel.id, text, unfurl_links: false });
}

function reauthSteps(b) {
  const env = Object.entries(b.env).map(([k, v]) => `${k}=${v} `).join("");
  return [
    `1. From your laptop: \`ssh -L ${b.port}:127.0.0.1:${b.port} ashutosh@daltrax\``,
    `2. On daltrax: \`${env}${b.command} ${b.args.join(" ")}\``,
    `   Open the printed authorize link in your browser, sign in, then Ctrl+C once it connects.`,
    `3. \`openclaw mcp reload && openclaw mcp probe ${b.name}\``,
  ].join("\n");
}

function loadState() {
  try { return JSON.parse(readFileSync(STATE_FILE, "utf8")); } catch { return {}; }
}

if (process.argv.includes("--test-alert")) {
  await dm(":white_check_mark: MCP keep-alive is set up. I'll DM you here when an MCP connection needs you to sign in again.");
  console.log("test alert sent");
  process.exit(0);
}

const state = loadState();
const now = Date.now();
let failures = 0;

for (const b of bridges) {
  const prev = state[b.name] ?? { status: "ok", errors: 0, lastAlert: 0 };
  const { status, detail } = await check(b);
  const errors = status === "error" ? (prev.errors ?? 0) + 1 : 0;
  const broken = status === "needs_auth" || errors >= ERRORS_BEFORE_ALERT;
  console.log(`${b.name}: ${status} (${detail})${status === "error" ? ` [${errors} in a row]` : ""}`);

  let lastAlert = prev.lastAlert ?? 0;
  try {
    if (broken && (!prev.broken || now - lastAlert >= REMIND_MS)) {
      const why = status === "needs_auth"
        ? "needs you to sign in again (its saved login was expired or revoked)"
        : `has failed ${errors} checks in a row: ${detail}`;
      await dm(`:warning: *OpenClaw MCP \`${b.name}\`* ${why}.\nServer: ${b.url}\n\n${status === "needs_auth" ? reauthSteps(b) : "Check: `openclaw mcp probe " + b.name + "`"}`);
      lastAlert = now;
    } else if (!broken && prev.broken) {
      await dm(`:white_check_mark: OpenClaw MCP \`${b.name}\` is working again.`);
      lastAlert = 0;
    }
  } catch (e) {
    console.error(`${b.name}: Slack alert failed: ${e.message}`);
  }
  if (broken) failures++;
  state[b.name] = { status, detail, errors, broken, lastAlert, checkedAt: new Date(now).toISOString() };
}

if (!DRY_RUN) {
  mkdirSync(STATE_DIR, { recursive: true });
  writeFileSync(STATE_FILE, JSON.stringify(state, null, 2) + "\n");
}
process.exit(failures > 0 ? 1 : 0);
