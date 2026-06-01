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
- Laptop stays awake when the lid is closed (assumes the machine is always on AC).
- Default user is `ashutosh`. Rename in `hosts/daltrax/default.nix` and `home/linux.nix` for your own use.
- Convenience alias `nrs` rebuilds the system: `sudo nixos-rebuild switch --flake ~/nixos-dotfiles#daltrax`.
