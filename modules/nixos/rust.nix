{ pkgs, ... }:

# Baseline Rust toolchain for "casual / system Rust" usage. Per-project
# version pinning belongs in each project's own flake.nix devShell and is
# independent of what this module installs.
#
# Includes `gcc` because cargo needs a C linker for most crates and `gcc` is
# generally useful (ad-hoc `cc foo.c`, etc.). Library/build-tool deps that
# only specific projects need — pkg-config, openssl, libpq, sqlite — belong
# in each project's `flake.nix` (nativeBuildInputs / buildInputs), not here.
{
	environment.systemPackages = with pkgs; [
		cargo
		rustc
		rust-analyzer
		gcc
	];
}
