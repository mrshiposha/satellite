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
      "editor.fontFamily" = "mononoki, Cambria Math";
      "window.zoomLevel" = 1.5;
      "window.menuBarVisibility" = "toggle";
    };
  };
}
