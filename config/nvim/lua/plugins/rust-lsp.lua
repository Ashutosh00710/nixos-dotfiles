return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      rust_analyzer = {
        cmd = { "rust-analyzer" },
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              extraArgs = { "--config", ".cargo/config.local.toml" },
            },
            checkOnSave = {
              command = "clippy",
              extraArgs = { "--all-targets", "--all-features" },
            },
            procMacro = {
              -- Let rust-analyzer locate its own bundled proc-macro server
              -- (the nix-provided binary knows where it is). No hardcoded path.
              enable = true,
            },
            inlayHints = {
              enable = true,
              showTestsHints = true,
            },
          },
        },
      },
    },
  },
}
