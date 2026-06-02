{ config, pkgs, ... }:

# Cross-platform user configuration. Anything here must work on both NixOS
# and macOS (when this repo grows a darwin entry). OS-specific additions
# live in home/linux.nix and a future home/darwin.nix.
{
	home.stateVersion = "26.05";

	home.packages = with pkgs; [
		bat
		btop
	];

	programs.git = {
		enable = true;
		settings = {
			user.name = "Ashutosh";
			user.email = "starcdwivedi@gmail.com";
			init.defaultBranch = "main";
			pull.ff = "only";
			push.autoSetupRemote = true;
		};
	};

	programs.delta = {
		enable = true;
		enableGitIntegration = true;
		options = {
			navigate = true;
			line-numbers = true;
		};
	};

	programs.gh = {
		enable = true;
		settings = {
			git_protocol = "ssh";
		};
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
			gck = "git checkout";
			gph = "git push";
			gpl = "git pull";
			gfa = "git fetch --all";
			gst = "git status";
			cat = "bat";
		};
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
				format = " [$symbol$state(\\($name\\))]($style)";
				style = "bold blue";
			};
		};
	};
}
