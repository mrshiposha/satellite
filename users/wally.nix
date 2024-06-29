{ config, ... }: {
  users.users.wally = {
    isNormalUser = true;
    description = "Valentina Shiposha";
  };

  home-manager.users.wally = {
    imports = [
      ./common/programs/fundamental
      ./common/programs/basic
      ./common/images/wallpapers.nix
    ];

    home.stateVersion = config.system.stateVersion;
  };
}
