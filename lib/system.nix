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
        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
          "repl-flake"
        ];
      }

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ] ++ configuration.modules;
  }
)
