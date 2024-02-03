{ config, lib, ... }:

let
  optional = lib.optionalAttrs;
in

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",preferred,auto,auto";

      input = {
        kb_layout = "us";

        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.4;
          tap-to-click = false;
        };

        sensitivity = 0;
      };

      misc.force_default_wallpaper = false;

      general = {
        gaps_in = 2;
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "dwindle";
        allow_tearing = false;
      };

      decoration.rounding = 15;

      animations = {
        enabled = true;

        bezier = "openBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, openBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      xwayland = {
        force_zero_scaling = true;
      };

      env = "XCURSOR_SIZE,24";

      workspace = [
        "1,persistent:true"
        "2,persistent:true"
        "3,persistent:true"
        "4,persistent:true"
      ];

      "$mainMod" = "Super";
      "$terminal" = "alacritty";
      "$reloadWaybar" = "pkill waybar ; waybar";

      bind = [
        "$mainMod+Shift, Return, exec, $terminal"
        "Super_L, P, exec, $terminal"

        "$mainMod, Return, exec, rofi -show drun -show-icons"
        "$mainMod, Q, killactive,"
        "$mainMod+Shift, E, exit,"
        "$mainMod+Shift, C, exec, $reloadWaybar"
        "$mainMod+Shift, F, togglefloating,"

        ", XF86AudioRaiseVolume, exec, pamixer --increase 5"
        ", XF86AudioLowerVolume, exec, pamixer --decrease 5"
        ", XF86AudioMute, exec, pamixer --toggle-mute"
        ", XF86AudioMicMute, exec, pamixer --source 58 --toggle-mute"

        ", XF86MonBrightnessUp, exec, brightnessctl -q set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl -q set 5%-"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"

        "$mainMod+Shift, 1, movetoworkspacesilent, 1"
        "$mainMod+Shift, 2, movetoworkspacesilent, 2"
        "$mainMod+Shift, 3, movetoworkspacesilent, 3"
        "$mainMod+Shift, 4, movetoworkspacesilent, 4"

        "$mainMod, Right, workspace, e+1"
        "$mainMod, Left, workspace, e-1"

        "$mainMod+Shift, Right, movetoworkspace, e+1"
        "$mainMod+Shift, Left, movetoworkspace, e-1"
      ];

      gestures = {
        workspace_swipe = true;
        workspace_swipe_distance = 150;
      };

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    } // optional config.programs.waybar.enable {
      exec-once = [
        "waybar"
        (builtins.toString ./init-workspaces.sh)
      ];
    };
  };
}
