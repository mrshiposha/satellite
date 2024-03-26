{ pkgs, ... }: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "wezterm";
    theme = ./theme.rasi;
    plugins = [
      pkgs.rofi-calc
      pkgs.rofi-power-menu
    ];
    extraConfig.modes = "drun,power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu,calc";
  };
}
