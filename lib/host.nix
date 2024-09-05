lib:
inputs@{ home-manager, ... }:
configurationPath:
let
	configuration = (import configurationPath lib inputs);
	defaultHostName = builtins.baseNameOf configurationPath;
in
lib.nixosSystem (
	configuration
		// {
		modules = [
			lib.household.modules.system

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

				networking.hostName = lib.mkDefault defaultHostName;
			}

			home-manager.nixosModules.home-manager
			{
				home-manager.useGlobalPkgs = true;
				home-manager.useUserPackages = true;
			}
		] ++ configuration.modules;
	}
)
