# nixos-dotfiles

Personal NixOS configuration. Hyprland on Wayland, managed declaratively with Nix flakes and home-manager.

## Stack

| Layer | Tool |
| --- | --- |
| OS | NixOS (unstable) |
| Compositor | Hyprland (with UWSM) |
| Display manager | ly |
| Bar | Waybar |
| Launcher | Wofi |
| Terminal | Ghostty / Kitty |
| Editor | Neovim |
| Browser | Firefox |
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
- Default user is `ashutosh`. Rename in `configuration.nix` and `home.nix` for your own use.
