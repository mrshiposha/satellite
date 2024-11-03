{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/24.05";
		flake-parts.url = "github:hercules-ci/flake-parts";
		home-manager = {
			url = "github:nix-community/home-manager/release-24.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		fleet = {
			url = "github:CertainLach/fleet";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs@{ nixpkgs, flake-parts, fleet, home-manager, ... }:
	let
		household = (import ./lib).household;
	in
		flake-parts.lib.mkFlake { inherit inputs; } {
			imports = [ fleet.flakeModules.default ];

			systems = [ "x86_64-linux" ];
			perSystem = { pkgs, config, system, ... }: {
				_module.args.pkgs = import nixpkgs { inherit system; };

				devShells.default = pkgs.mkShell {
					packages = [ fleet.packages.${system}.fleet ];
				};
			};

			fleetConfigurations.default = {
				nixpkgs.buildUsing = nixpkgs;

				nixos.config._module.args.household = household;
				nixos.imports = [
					household.modules.system
					home-manager.nixosModules.home-manager
					{
						# Make `nix shell nixpkgs#thing` use the same nixpkgs, as used to build the system.
						nix = {
							registry.nixpkgs = {
								from = { id = "nixpkgs"; type = "indirect"; };
								flake = nixpkgs;
								exact = false;
							};
							settings = {
								# see https://github.com/NixOS/nix/pull/7126#issuecomment-1820045768
								# replace with https://github.com/NixOS/nix/pull/7126 when ready
								sync-before-registering = true;

								trusted-users = [ "@wheel" ];

								experimental-features = [
									"nix-command"
									"flakes"
									"repl-flake"
								];
							};
						};
						home-manager = {
							useGlobalPkgs = true;
							useUserPackages = true;
						};
					}
				];

				hosts.satellite = import ./hosts/satellite;
			};
		};
}
