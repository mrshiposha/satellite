{ config, pkgs, ... }: with pkgs; {
  users.users.mrshiposha = {
    isNormalUser = true;

    shell = zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  home-manager.users.mrshiposha = {
    imports = [ ./programs ];

    programs.git = {
      enable = true;
      userName = "Daniel Shiposha";
      userEmail = "ds@unique.network";
    };

    home.stateVersion = config.system.stateVersion;
  };
}
