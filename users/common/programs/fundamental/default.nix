{ pkgs, ... }: with pkgs; {
  imports = [
    ./zsh
    ./hyprland
    ./waybar
    ./rofi
    ./mako.nix
  ];

  home.packages = [
    networkmanagerapplet
    pavucontrol
    pamixer
    brightnessctl
    qalculate-gtk
  ];
}
