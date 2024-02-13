{ config, pkgs, ... }:

let
  hyprland = config.wayland.windowManager.hyprland;

  gapsout = if hyprland.enable
    then hyprland.settings.general.gaps_out
    else 4;
in

{
  home.packages = [ pkgs.libnotify ];

  services.mako = {
    enable = true;

    maxVisible = -1;
    layer = "overlay";
    font = "monospace 12";
    backgroundColor = "#4c566a9d";
    borderColor = "#4c566a9d";
    textColor = "#D8DEE9";
    borderRadius = 15;
    maxIconSize = 48;
    defaultTimeout = 2500;
    anchor = "bottom-right";
    margin = builtins.toString (gapsout + 20);
    width = 426;
  };
}
