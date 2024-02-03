{ config, ... }: 

let
  hyprland = config.wayland.windowManager.hyprland;

  gapsout = if hyprland.enable
    then hyprland.settings.general.gaps_out
    else 4;
in

{
  programs.waybar = {
    enable = true;
    settings.main = {
      layer = "top";
      position = "bottom";

      margin-bottom = gapsout;
      margin-left = gapsout;
      margin-right = gapsout;

      modules-left = [
        "hyprland/workspaces"
        "backlight"
        "pulseaudio"
      ];
      modules-center = ["clock"];
      modules-right = [
        "network"
        "bluetooth"
        "battery"
      ];

      "hyprland/workspaces" = {
        format = "{windows}";
        persistent-workspaces."*" = 4;
        "window-rewrite-default" = "<sub></sub>";
        window-rewrite = {
          "rofi" = "";
          "alacritty" = "";
          "codium" = "󰨞";
          "class<firefox>" = "";
          "class<firefox> title<.*youtube.*>" = "";
          "telegram" = "";
          "slack" = "";
          "pavucontrol" = "<sub></sub>";

          "class<firefox> title<.*Gmail.*>" = "";
          "thunderbird" = "";          
        };
      };

      clock.format = "{:%H:%M} ";

      backlight = {
        format = "{percent}% {icon}";
        format-icons = [""];
      };

      pulseaudio = {
        format = "{volume}% {icon}";
        format-icons.default = [""];
        format-muted = "<sub></sub>";
        tooltip-format = "Sound Volume {volume}%";
        on-click = "pavucontrol";
      };

      bluetooth = {
        format = "";

        tooltip-format = "Bluetooth {status}";
        tooltip-format-connected = "{device_alias}";
        tooltip-format-connected-battery = "{device_alias}<sub> {device_battery_percentage}%</sub>";

        on-click = "rfkill toggle bluetooth";
        on-click-right = "blueman-manager";
      };

      network = {
        interface = "wlan0";
        format-wifi = "<sub></sub>";
        format-linked = "<sub></sub>";
        format-disconnected = "<sub></sub>";

        tooltip-format-wifi = "{essid}\nIP: {ipaddr}\nStrength: {signalStrength}%";
        tooltip-format-linked = "connecting to {essid}";
        tooltip-format-disconnected = "WiFi disconnected";

        on-click = "rfkill toggle wlan";
        on-click-right = "nm-connection-editor";
      };

      battery = {
        format = "{capacity}% {icon}";
        format-charging = "{capacity}% {icon}";
        format-icons = ["" "" "" "" ""];
        states = {
          warning = 30;
          critical = 15;
        };
      };
    };

    style = builtins.readFile ./style.css;
  };
}
