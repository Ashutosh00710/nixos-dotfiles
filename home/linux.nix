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

	# Global cargo config (Linux-only). Fixes for a low-RAM machine:
	#   1. Link via clang -> wild instead of the default bfd linker. wild is
	#      fast and memory-frugal. (wild + clang come from modules/nixos/rust.nix.)
	#   2. codegen-units=256 — splits each crate into many small LLVM modules so
	#      a single rustc's PEAK memory stays low. Release defaults to only 16,
	#      which let one rustc balloon past 4 GiB and freeze the machine; 256
	#      (the debug default) chunks it far smaller. The real memory hog is the
	#      codegen phase, not linking, so this matters more than the linker swap.
	#   3. Cap parallel build jobs at 4 (of 8 cores) to keep RAM headroom.
	# Per-project flake devShells can still override any of these. For iteration
	# prefer `cargo build` (debug) over `--release` — debug rustc uses far less
	# memory.
	home.file.".cargo/config.toml".text = ''
		[target.x86_64-unknown-linux-gnu]
		linker = "clang"
		rustflags = ["-C", "link-arg=--ld-path=wild", "-C", "codegen-units=256"]

		[build]
		jobs = 4
	'';

	# On-screen display for volume / brightness / caps-lock state. Used by the
	# swayosd-client invocations bound to media keys in hyprland.conf — the
	# daemon both performs the action (via wpctl / brightnessctl) and shows
	# the OSD bar.
	services.swayosd.enable = true;
}
