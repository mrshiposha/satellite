{ pkgs, ... }: {
  imports = [
    ./zsh
    ./hyprland
    ./waybar
    ./rofi
    ./mako.nix
    ./themes.nix
  ];

  home.packages = with pkgs; [
    networkmanagerapplet
    pavucontrol
    pamixer
    brightnessctl
    qalculate-gtk
    xdg-utils
  ];
}
