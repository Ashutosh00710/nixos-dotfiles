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
├── configuration.nix          # System-level NixOS config
├── hardware-configuration.nix # Machine-specific, generated
├── home.nix                   # home-manager (user-level) config
└── config/
    ├── hypr/                  # Hyprland config
    └── waybar/                # Waybar config + styles
```

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
- Default user is `ashutosh`. Rename in `configuration.nix` and `home.nix` for your own use.
