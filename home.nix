{ config, pkgs, ... }:

{
	home.username = "ashutosh";
	home.homeDirectory = "/home/ashutosh";
	home.stateVersion = "26.05";
	programs.gh = {
		enable = true;
		settings = {
			git_protocol = "ssh";
		};
	};
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
	home.file.".config/hypr".source = ./config/hypr;
	home.file.".config/waybar".source = ./config/waybar;
}
