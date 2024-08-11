{ pkgs, ... }:
{
  imports = [
    ./zsh
    ./hyprland
    ./waybar
    ./rofi
    ./mako.nix
  ];

  home.packages = with pkgs; [
    pavucontrol
    pamixer
    brightnessctl
    qalculate-gtk
    xdg-utils
    trash-cli
  ];

	xdg.mimeApps.enable = true;
}
