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

    programs.git = {
      enable = true;
      userName = "Daniel Shiposha";
      userEmail = "ds@unique.network";
    };

    home.stateVersion = config.system.stateVersion;
  };
}
