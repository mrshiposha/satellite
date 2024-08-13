{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/24.05";
		home-manager = {
			url = "github:nix-community/home-manager/release-24.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs =
		inputs@{ nixpkgs, ... }:
		let
			mkLib = nixpkgs: nixpkgs.lib.extend (final: prev: import ./lib);

			lib = mkLib nixpkgs;

			system = import ./lib/system.nix lib inputs;
		in
		{
			nixosConfigurations.satellite = system ./hosts/satellite;
		};
}
