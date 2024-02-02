{ pkgs, ... }: {
  imports = [
    ./boot.nix
    ./fonts.nix
    ./net.nix
    ./audio.nix
  ];

  system.stateVersion = "23.11";

  hardware.enableRedistributableFirmware = true;

  i18n.defaultLocale = "en_US.UTF-8";

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true; 
  };

  users.defaultUserShell = pkgs.zsh;

  # FIXME in 23.11 the binary from the home-manager crashes.
  # Remove this in the future version of NixOS.
  programs.hyprland.enable = true;

  programs.wshowkeys.enable = true;
}