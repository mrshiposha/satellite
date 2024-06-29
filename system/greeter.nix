{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.nordic ];

  programs.regreet = {
    enable = true;
    settings = {
      background = {
        path = ./images/nord_waves.png;
        fit = "Contain";
      };

      GTK = {
        theme_name = "Nordic";
        #cursor_theme_name = "Quintom_Ink";
        #icon_theme_name = "Zafiro-icons-Dark";
      };
    };
  };
}
