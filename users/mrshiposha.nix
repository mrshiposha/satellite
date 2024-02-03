{ config, pkgs, ... }: with pkgs; {
  users.users.mrshiposha = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  home-manager.users.mrshiposha = {
    imports = [ ./common/programs ];

    home.packages = [ rustup ];

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
