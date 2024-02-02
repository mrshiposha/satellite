{ pkgs, ... }: with pkgs; {
  imports = [
    ./zsh
    ./hyprland.nix
    ./rofi.nix
  ];

  home.packages = [
    networkmanagerapplet
  ];
}
