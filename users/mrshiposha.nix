{ config, pkgs, ... }: {
  users.users.mrshiposha = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ];
  };

  home-manager.users.mrshiposha = {
    imports = [
      ./common/programs
      ./common/images/wallpapers.nix
    ];

    home.packages = with pkgs; [
      rustup
      lapce
    ];

    programs = {
      git = {
        enable = true;
        userName = "Daniel Shiposha";
        userEmail = "ds@unique.network";
      };

      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };

    home.stateVersion = config.system.stateVersion;
  };
}
