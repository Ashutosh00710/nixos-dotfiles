{ config, pkgs, ... }:

# Linux-only user configuration. Imports the shared cross-platform baseline
# and layers on things that only make sense on NixOS (or any Linux desktop):
# Hyprland tty1 fallback, sudo wrapper PATH fix, raw hypr/waybar configs.
{
	imports = [ ./default.nix ];

	home.username = "ashutosh";
	home.homeDirectory = "/home/ashutosh";

	programs.bash = {
		enable = true;
		shellAliases = {
			cls = "clear";
		};
		profileExtra = ''
			if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ] && ! pgrep -x ly >/dev/null; then
				exec uwsm start hyprland-uwsm.desktop
			fi
		'';
	};

	programs.zsh = {
		# Keep /run/wrappers/bin ahead of /run/current-system/sw/bin so the
		# setuid sudo wrapper resolves first (NixOS zsh init re-prepends profile
		# paths after wrappers, demoting them otherwise).
		envExtra = ''
			export PATH="/run/wrappers/bin:$PATH"
		'';
		shellAliases = {
			nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#daltrax";
		};
		profileExtra = ''
			if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ] && ! pgrep -x ly >/dev/null; then
				exec uwsm start hyprland-uwsm.desktop
			fi
		'';
	};

	home.file.".config/hypr".source = ../config/hypr;
	home.file.".config/waybar".source = ../config/waybar;
}
