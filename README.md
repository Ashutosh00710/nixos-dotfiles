# nixos-dotfiles

Personal NixOS configuration. Hyprland on Wayland, managed declaratively with Nix flakes and home-manager.

## Stack

| Layer | Tool |
| --- | --- |
| OS | NixOS (unstable) |
| Compositor | Hyprland (with UWSM) |
| Display manager | ly |
| Shell | Zsh + autosuggestion + syntax highlighting |
| Prompt | Starship |
| Tooling | eza, fzf, zoxide, gh |
| Git | git + delta (top-down diff with line numbers) |
| Bar | Waybar |
| Launcher | Wofi |
| Terminal | Ghostty / Kitty |
| Font | FiraCode Nerd Font |
| Editor | Neovim |
| Browser | Firefox |
| Audio | PipeWire (with PulseAudio shim) |
| Networking | NetworkManager + Tailscale |

## Structure

```
.
├── flake.nix                  # Flake entry point + inputs
├── flake.lock
├── hosts/                     # Per-machine system config
│   └── daltrax/
│       ├── default.nix        # System-level NixOS config for this host
│       └── hardware-configuration.nix
├── home/                      # home-manager (user-level) config
│   ├── default.nix            # Cross-platform baseline (zsh, git, gh, eza, ...)
│   └── linux.nix              # Linux-only additions, imports default
├── modules/                   # Reusable system modules, imported by hosts
│   └── nixos/
│       └── rust.nix           # Rust toolchain (cargo, rustc, wild linker, ...)
└── config/                    # Raw config files sourced via home.file
    ├── hypr/                  # Hyprland config
    └── waybar/                # Waybar config + styles
```

The split lets the same `home/default.nix` get reused later from a Mac
(via standalone home-manager) by importing it from a sibling `darwin.nix`.

## Usage

```bash
git clone git@github.com:Ashutosh00710/nixos-dotfiles.git
cd nixos-dotfiles
sudo nixos-rebuild switch --flake .#daltrax
```

Replace `daltrax` with whatever you name your host in `flake.nix` under `nixosConfigurations`.

## Notes

- `hardware-configuration.nix` is machine-specific. Regenerate with `nixos-generate-config` before rebuilding on a new machine.
- Tailscale SSH is enabled — run `sudo tailscale up --ssh` once after install to authenticate.
- `CapsLock` is remapped to `Ctrl` system-wide (Hyprland + virtual consoles + ly login).
- Closing the lid turns the laptop panel off but keeps the system running (so SSH/Tailscale stay reachable); opening it restores the display. Assumes the machine is always on AC.
- Default user is `ashutosh`. Rename in `hosts/daltrax/default.nix` and `home/linux.nix` for your own use.
- Convenience alias `nrs` rebuilds the system: `sudo nixos-rebuild switch --flake ~/nixos-dotfiles#daltrax`.
- Rust projects use per-directory dev shells: drop a `flake.nix` (devShell) + `.envrc` containing `use flake` in the project, run `direnv allow`, and the toolchain/libs load automatically on `cd`. Project-specific libraries (openssl, etc.) go in that flake's `buildInputs`, not the system config.
- Low-RAM build tuning (see `hosts/daltrax/default.nix` + `home/linux.nix`): zram + an 8 GiB swapfile, the `wild` linker, and `codegen-units=256` keep a single `rustc` from exhausting memory and freezing the machine. Prefer `cargo build` (debug) over `--release` while iterating.
