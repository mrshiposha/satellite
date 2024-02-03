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
    settings.main = rec {
      layer = "top";
      position = "bottom";

      margin-bottom = gapsout;
      margin-left = gapsout;
      margin-right = gapsout;

      modules-left = [
        "hyprland/workspaces"
      ];
      modules-center = ["clock"];
      modules-right = [
        "backlight"
        "pulseaudio"
        "network"
        "bluetooth"
        "battery"
        "group/stats"
      ];

      "hyprland/workspaces" = {
        format = "{windows}";
        persistent-workspaces."*" = 4;
        "window-rewrite-default" = "<sub></sub>";
        window-rewrite = {
          "class<rofi>" = "";
          "class<alacritty>" = "";
          "class<VSCodium>" = "󰨞";
          "class<firefox>" = "";
          "class<firefox> title<.*youtube.*>" = "";
          "class<firefox> title<.*Meet -.*>" = "<sub></sub>";
          "class<org.telegram.desktop>" = "";
          "class<slack>" = "";
          "class<discord>" = "";

          "class<pavucontrol>" = "<sub></sub>";
          "class<nm-connection-editor>" = "<sub></sub>";
          "class<.blueman-manager-wrapped>" = "<sub></sub>";

          "class<firefox> title<.*Gmail.*>" = "<sub></sub>";
          "class<thunderbird>" = "";

          "class<qalculate-gtk>" = "";
        };
      };

      clock.format = "{:%H:%M} ";

      backlight.format = "{percent}% ";

      pulseaudio = {
        format = "{volume}%  / {format_source}";
        format-muted = "<sub></sub> / {format_source}";
        format-source = "";
        format-source-muted = "<sub></sub>";
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

      "group/stats" = {
        orientation = "inherit";
        modules = [
          "cpu"
          "disk"
          "memory"
        ];

        drawer = {
          transition-duration = 500;
        };
      };

      cpu = {
        format = "{usage}% ";
        on-click = "alacritty -e btop";
      };
      memory = {
        format = "{percentage}% RAM";
        on-click = cpu.on-click;
      };
      disk.format = "{percentage_used}% ";

      battery = {
        format = "{capacity}% {icon}";
        format-charging = "{capacity}% {icon}<sub></sub>";
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
