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
      ./common/programs/program-main-set.nix
      ./common/programs/vscode.nix
      ./common/programs/neovim
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
