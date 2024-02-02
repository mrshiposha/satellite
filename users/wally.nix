{ config, pkgs, ... }: with pkgs; {
  users.users.wally = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
    ];
  };

  home-manager.users.wally = {
    imports = [ ./common/programs ];

    home.stateVersion = config.system.stateVersion;
  };
}
