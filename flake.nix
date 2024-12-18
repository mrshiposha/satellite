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
		navigatorUser = import ./navigator.nix;
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
					navigatorUser
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

								trusted-users = [
									"root"
									"@wheel"
								];
								trusted-public-keys = [
									"satellite-1:AAMTT4U2aR46/PhIa0HxcNnqN9IfTI6uCXICcxA1yQY="
								];

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

						security.sudo.extraConfig = ''
							Defaults:root,%wheel timestamp_timeout=0
						'';
					}
				];

				hosts = {
					satellite = import ./hosts/satellite;
					sentinel = import ./hosts/sentinel {
						ip.addr = {
							v6 = [];
							v4 = [
								{
									address = "192.168.0.30";
									prefixLength = 24;
								}
							];
						};
					};
				};
			};
		};
}
