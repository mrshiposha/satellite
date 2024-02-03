{ nixosConfig, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
    userSettings = {
      "terminal.integrated.fontFamily" = builtins.elemAt
        nixosConfig.fonts.fontconfig.defaultFonts.monospace
        0;
      
      "files.insertFinalNewline" = true;
      "editor.fontFamily" = "'Font Awesome 6 Free', 'Font Awesome 6 Brands'";
      "window.zoomLevel" = 2;
    };
  };
}
