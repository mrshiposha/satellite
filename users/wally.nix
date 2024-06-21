{ config, ... }: {
  users.users.wally = {
    isNormalUser = true;
    description = "Valentina Shiposha";
  };

  home-manager.users.wally = {
    imports = [
      ./common/programs
      ./common/images/wallpapers.nix
    ];

    home.stateVersion = config.system.stateVersion;
  };
}
