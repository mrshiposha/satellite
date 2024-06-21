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

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true; 
  };

  users.defaultUserShell = pkgs.zsh;

  environment.systemPackages = [ pkgs.llvmPackages.clangUseLLVM ];

  # FIXME in 23.11 the binary from the home-manager crashes.
  # Remove this in the future version of NixOS.
  programs.hyprland.enable = true;

  programs.wshowkeys.enable = true;
}
