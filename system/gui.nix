{ pkgs, ... }: {
  programs = {
    hyprland.enable = true;
    wshowkeys.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # TODO separate theming module
    nordic
    quintom-cursor-theme
    zafiro-icons

    libsForQt5.qt5.qtwayland
    qt6.qtwayland
  ];


  programs.regreet = {
    enable = true;
    settings = {
      background = {
        path = ./images/nord_waves.png;
        fit = "Contain";
      };

      GTK = {
        theme_name = "Nordic";
        cursor_theme_name = "Quintom_Ink";
        icon_theme_name = "Zafiro-icons-Dark";
      };
    };
  };
}
