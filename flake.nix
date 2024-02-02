{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/23.11;
    home-manager = {
      url = github:nix-community/home-manager/release-23.11;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    nixosConfigurations.satellite = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        {
          nix.settings.experimental-features = [
            "nix-command"
            "flakes"
            "repl-flake"
          ];
        }

        ./hardware-configuration.nix
        ./system

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
        ./users
        ./unfree-list.nix
      ];
    };
  };
}
