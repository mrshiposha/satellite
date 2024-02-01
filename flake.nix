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
        ./hardware-configuration.nix
        ./boot.nix

        {
          hardware.enableRedistributableFirmware = true;

          nix.settings.experimental-features = [
            "nix-command"
            "flakes"
            "repl-flake"
          ];

          system.stateVersion = "23.11";
          i18n.defaultLocale = "en_US.UTF-8";

          # FIXME in 23.11 the binary from the home-manager crashes.
          # Remove this in the future version of NixOS.
          programs.hyprland.enable = true;
        }

        ./net.nix

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
