lib:
inputs@{ home-manager, ... }:
configurationPath:
let
	configuration = (import configurationPath lib inputs);
in
lib.nixosSystem (
	configuration
		// {
		modules = [
			{
				nix.settings = {
					# see https://github.com/NixOS/nix/pull/7126#issuecomment-1820045768
					# replace with https://github.com/NixOS/nix/pull/7126 when ready
					sync-before-registering = true;

					experimental-features = [
						"nix-command"
						"flakes"
						"repl-flake"
					];
				};
			}

			home-manager.nixosModules.home-manager
			{
				home-manager.useGlobalPkgs = true;
				home-manager.useUserPackages = true;
			}
		] ++ configuration.modules;
	}
)
