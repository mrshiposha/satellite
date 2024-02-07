{ config, ... }: {
  users.users.wally = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
    ];
  };

  home-manager.users.wally = {
    imports = [
      ./common/programs
      ./common/images/wallpapers.nix
    ];

    home.stateVersion = config.system.stateVersion;
  };
}
