{ pkgs, ... }: {
  imports = [
    ./boot.nix
    ./fonts.nix
    ./greeter.nix
    ./net.nix
    ./audio.nix
    ./docker.nix
    ./powersave.nix
    ./security.nix
    ./qt.nix
    ./erp.nix
  ];

  system.stateVersion = "23.11";

  hardware.enableRedistributableFirmware = true;

  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = [ pkgs.llvmPackages.clangUseLLVM ];

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
    };
    hyprland.enable = true;
    wshowkeys.enable = true;
    steam.enable = true;
  };
  users.defaultUserShell = pkgs.zsh;
}
