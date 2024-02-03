{ pkgs, ... }: {
  gtk = {
    enable = true;
    theme = {
      package = pkgs.nordic;
      name = "Nordic";
    };
    cursorTheme = {
      package = pkgs.quintom-cursor-theme;
      name = "Quintom_Ink";
    };
    iconTheme = {
      package = pkgs.zafiro-icons;
      name = "Zafiro-icons-Dark";
    };

    # FIXME doesn't work
    gtk4.extraConfig = {
      gtk-theme-name = "Nordic";
    };
  };

  home.sessionVariables = {
    XCURSOR_THEME = "Quintom_Ink";
  };

  services.xsettingsd = {
    enable = true;
    settings = {
      "Gtk/CursorThemeName" = "Quintom_Ink";
      "Net/ThemeName" = "Nordic";
    };
  };

  qt = {
    enable = true;
    platformTheme = "qtct";
    style = {
      package = pkgs.nordic;
      name = "Nordic";
    };
  };
}
