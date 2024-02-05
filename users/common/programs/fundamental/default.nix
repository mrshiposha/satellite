{ pkgs, ... }: with pkgs; {
  imports = [
    ./zsh
    ./hyprland
    ./waybar
    ./rofi
    ./mako.nix
    ./themes.nix
  ];

  home.packages = [
    networkmanagerapplet
    pavucontrol
    pamixer
    brightnessctl
    qalculate-gtk
    xdg-utils
  ];
}
