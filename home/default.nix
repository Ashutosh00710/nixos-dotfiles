{ config, pkgs, ... }:

# Cross-platform user configuration. Anything here must work on both NixOS
# and macOS (when this repo grows a darwin entry). OS-specific additions
# live in home/linux.nix and a future home/darwin.nix.
{
	home.stateVersion = "26.05";

	home.packages = with pkgs; [
		bat
		btop
		fastfetch
		neovim
		(callPackage ../pkgs/gogcli.nix { })  # `gog` — Google Workspace CLI, latest release binary
		# yazi deps: cross-platform
		fd             # file finding (yazi's file search)
		ripgrep        # content searching inside yazi
		jq             # JSON preview
		p7zip          # archive preview/extraction (provides 7zz)
		resvg          # SVG preview
		imagemagick    # HEIC / JPEG XL / font preview
		wl-clipboard   # clipboard (wl-copy/wl-paste) — Linux Wayland
	];

	# LazyVim config lives in this repo at config/nvim. Symlinked OUT of the
	# nix store (mkOutOfStoreSymlink) rather than copied in, because lazy.nvim
	# writes back to its own dir (lazy-lock.json on `:Lazy update`) and edits
	# should be live without a rebuild. Resolves on both Linux and macOS as
	# long as the repo is cloned at ~/nixos-dotfiles. lazy-lock.json is
	# committed, so plugin versions stay pinned across machines.
	xdg.configFile."nvim".source =
		config.lib.file.mkOutOfStoreSymlink
			"${config.home.homeDirectory}/nixos-dotfiles/config/nvim";

	# Globally-installed npm CLIs (npm i -g ...) land under ~/.npm-global so
	# they never need root. Set the prefix here instead of a hand-written
	# ~/.npmrc, and put its bin dir on PATH so the tools (nx, etc.) resolve.
	home.sessionVariables.NPM_CONFIG_PREFIX = "${config.home.homeDirectory}/.npm-global";
	home.sessionPath = [ "$HOME/.npm-global/bin" ];

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

	# direnv + nix-direnv: auto-load per-project nix devShells when you cd into
	# a directory with `.envrc` containing `use flake`. Drop the manual
	# `nix develop` invocation entirely. Cross-platform (works on macOS too).
	programs.direnv = {
		enable = true;
		nix-direnv.enable = true;
	};

	programs.zsh = {
		enable = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
		enableCompletion = true;
		history.size = 10000;
		# Secrets are read from out-of-store files at startup so the values never
		# land in /nix/store (world-readable) or git. Create the file once:
		#   mkdir -p ~/.config/gog
		#   printf '%s' 'your-password' > ~/.config/gog/keyring-password
		#   chmod 600 ~/.config/gog/keyring-password
		# Goes in .zshenv (envExtra) so it's set for every zsh, including the
		# non-interactive shells gog may be invoked from.
		envExtra = ''
			[ -r "$HOME/.config/gog/keyring-password" ] && \
				export GOG_KEYRING_PASSWORD="$(< "$HOME/.config/gog/keyring-password")"
		'';
		initContent = ''
			fastfetch
		'';
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

	# yazi: terminal file manager. Shell wrapper `y` auto-changes the working
	# directory on exit (so `cd` to where you navigated). All preview deps
	# (fd, ripgrep, jq, p7zip, resvg, imagemagick) are declared in
	# home.packages above. Video thumbnails (ffmpegthumbnailer) are Linux-only
	# and declared in home/linux.nix.
	programs.yazi = {
		enable = true;
		enableZshIntegration = true;   # `y` wrapper changes CWD on exit
		settings = {
			manager = {
				show_hidden = false;
				sort_by = "natural";
				sort_sensitive = false;
				sort_reverse = false;
				sort_dir_first = true;
				linemode = "size";
				show_symlink = true;
			};
			preview = {
				image_filter = "lanczos3";
				image_quality = 90;
				tab_size = 2;
				max_width = 600;
				max_height = 900;
			};
			opener = {
				# Open common file types with sensible defaults
				edit = [{ run = "nvim \"$@\""; block = true; }];
			};
		};
	};
}
