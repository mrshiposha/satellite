{ pkgs, ... }: {
  home.pointerCursor = {
    package = pkgs.quintom-cursor-theme;
    name = "Quintom_Ink";
    x11.enable = true;
    gtk.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.nordic;
      name = "Nordic";
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

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style = {
      package = pkgs.nordic;
      name = "Nordic";
    };
  };
}
