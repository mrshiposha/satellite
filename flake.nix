{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { nixpkgs, home-manager, ... }:
  let
    mkLib = nixpkgs:
        nixpkgs.lib.extend
        (final: prev: import ./lib);

    lib = mkLib nixpkgs;

    system = configurationPath:
      let
        configuration = (import configurationPath lib inputs);
      in
      lib.nixosSystem (configuration // {
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
      });
  in
  {
    nixosConfigurations.satellite = system ./hosts/satellite;
  };
}
