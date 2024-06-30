{ config, lib, pkgs, ... }:
with lib;
with types;
let
  cfg = config.gui;
in
{
  options.gui = {
    enable = mkEnableOption "GUI";

    greeter.seat0.theme = {
      wallpaper = mkOption {
        type = path;
      };

      style = {
        package = mkOption {
          type = package;
        };

        name = mkOption {
          type = str;
        };
      };

      cursors = {
        package = mkOption {
          type = package;
        };

        name = mkOption {
          type = str;
        };
      };

      icons = {
        package = mkOption {
          type = package;
        };

        name = mkOption {
          type = str;
        };
      };
    };
  };

  config = let
    greeterTheme = cfg.greeter.seat0.theme;
  in mkIf cfg.enable {
    programs = {
      hyprland.enable = true;
      wshowkeys.enable = true;
    };

    environment.systemPackages = with pkgs; [
      greeterTheme.style.package
      greeterTheme.cursors.package
      greeterTheme.icons.package

      libsForQt5.qt5.qtwayland
      qt6.qtwayland
    ];

    programs.regreet = {
      enable = true;
      settings = {
        background = {
          path = greeterTheme.wallpaper;
          fit = "Contain";
        };

        GTK = {
          theme_name = greeterTheme.style.name;
          cursor_theme_name = greeterTheme.cursors.name;
          icon_theme_name = greeterTheme.icons.name;
        };
      };
    };
  };
}
