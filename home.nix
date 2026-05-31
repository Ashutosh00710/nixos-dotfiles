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
	programs.zsh = {
		enable = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
		enableCompletion = true;
		history.size = 10000;
		shellAliases = {
			cls = "clear";
			ll = "eza --icons -l";
			la = "eza --icons -la";
		};
		profileExtra = ''
			if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ] && ! pgrep -x ly >/dev/null; then
				exec uwsm start hyprland-uwsm.desktop
			fi
		'';
	};
	programs.eza = {
		enable = true;
		enableZshIntegration = true;
		icons = "auto";
		git = true;
	};
	programs.fzf = {
		enable = true;
		enableZshIntegration = true;
	};
	programs.zoxide = {
		enable = true;
		enableZshIntegration = true;
	};
	programs.ghostty = {
		enable = true;
		settings = {
			font-family = "FiraCode Nerd Font";
			font-size = 12;
		};
	};
	programs.starship = {
		enable = true;
		enableZshIntegration = true;
		settings = {
			add_newline = false;
			command_timeout = 1000;

			format = "$directory$git_branch$git_status$nix_shell$rust$golang$nodejs$python$cmd_duration$line_break$character";

			character = {
				success_symbol = "[➜](bold green)";
				error_symbol = "[✗](bold red)";
			};

			directory = {
				style = "bold cyan";
				truncation_length = 3;
				truncate_to_repo = true;
				read_only = " 󰌾";
			};

			git_branch = {
				symbol = " ";
				style = "bold purple";
			};

			git_status = {
				style = "bold yellow";
				conflicted = "=";
				ahead = "⇡\${count}";
				behind = "⇣\${count}";
				diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
				untracked = "?\${count}";
				stashed = "\$";
				modified = "!\${count}";
				staged = "+\${count}";
				renamed = "»\${count}";
				deleted = "✘\${count}";
			};

			cmd_duration = {
				min_time = 2000;
				style = "yellow";
				format = " [$duration]($style)";
			};

			nix_shell = {
				symbol = " ";
				format = " [$symbol$state(\\($name\\))]($style)";
				style = "bold blue";
			};

			rust.symbol = " ";
			golang.symbol = " ";
			nodejs.symbol = " ";
			python.symbol = " ";
		};
	};
	home.file.".config/hypr".source = ./config/hypr;
	home.file.".config/waybar".source = ./config/waybar;
}
