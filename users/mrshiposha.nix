{ config, pkgs, ... }: {
  users.users.mrshiposha = {
    isNormalUser = true;
    description = "Daniel Shiposha";
    extraGroups = [
      "wheel"
      "docker"
    ];
  };

  home-manager.users.mrshiposha = {
    imports = [
      ./common/programs/fundamental
      ./common/programs/basic
      ./common/programs/dev/vscode.nix
      ./common/programs/dev/neovim
      ./common/images/wallpapers.nix
    ];

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
