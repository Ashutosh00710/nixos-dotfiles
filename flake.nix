{
	description = "Hyprland on NixOS";
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { nixpkgs, home-manager, ... }: {
		nixosConfigurations.daltrax = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./hosts/daltrax
				home-manager.nixosModules.home-manager
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.ashutosh = import ./home/linux.nix;
						backupFileExtension = "backup";
					};
				}
			];
		};
	};
}
