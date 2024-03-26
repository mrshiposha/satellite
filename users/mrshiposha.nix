{ config, pkgs, ... }: {
  users.users.mrshiposha = {
    isNormalUser = true;
    description = "Daniel Shiposha";
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
      ./programs/vscode.nix
      ./programs/neovim
    ];

    home.packages = with pkgs; [
      rustup
      qrencode
      inkscape
      neovide
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
