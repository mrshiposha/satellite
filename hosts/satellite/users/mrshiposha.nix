{
  config,
  lib,
  pkgs,
  ...
}:
{
  users.users.mrshiposha = {
    isNormalUser = true;
    description = "Daniel Shiposha";
    extraGroups = [
      "wheel"
      "docker"
    ];
  };

  home-manager.users.mrshiposha = {
    imports = builtins.map lib.household.common.user [
      /modules/basic
      /programs/fundamental
      /programs/basic
      /programs/dev/vscode.nix
      /programs/dev/neovim
    ];

    theming.gui.wallpapers = {
      active = lib.household.image /1920x1080/nord_mountains.png;
      screensaver = lib.household.image /1920x1080/nord_waves.png;
    };

    home.packages = with pkgs; [
      rustup
      qrencode
      inkscape
      neovide
      ghidra-bin
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
