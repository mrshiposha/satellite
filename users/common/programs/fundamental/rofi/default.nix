{ pkgs, ... }: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "wezterm";
    theme = ./theme.rasi;
    plugins = [
      # pkgs.rofi-calc -- broken, see https://github.com/NixOS/nixpkgs/issues/298539
      pkgs.rofi-power-menu
    ];
    # "calc" -- broken
    # extraConfig.modes = "drun,power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu,calc";
    extraConfig.modes = "drun,power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu";
  };
}
