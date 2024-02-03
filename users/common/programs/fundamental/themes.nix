{ pkgs, ... }: {
  gtk = {
    enable = true;
    theme = {
      package = pkgs.nordic;
      name = "Nordic";
    };
    gtk4.extraConfig = {
      gtk-theme-name = "Nordic";
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
