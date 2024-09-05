{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/24.05";
		flake-utils.url = "github:numtide/flake-utils";
		home-manager = {
			url = "github:nix-community/home-manager/release-24.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		fleet = {
			url = "github:CertainLach/fleet";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs =
		inputs@{ nixpkgs, flake-utils, fleet, ... }:
		let
			lib = nixpkgs.lib.extend (final: prev: import ./lib);
			host = import ./lib/host.nix lib inputs;
		in
			flake-utils.lib.eachDefaultSystem (lib.household.eachSystemConfig inputs) // {
				nixosConfigurations.satellite = host ./hosts/satellite;
			};
}
