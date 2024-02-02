{ nixosConfig, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
    userSettings = {
      "terminal.integrated.fontFamily" = builtins.elemAt
        nixosConfig.fonts.fontconfig.defaultFonts.monospace
        0;
      
      "files.inswerFinalNewline" = true;
      "editor.fontFamily" = "mononoki, Cambria Math";
      "window.zoomLevel" = 2;
    };
  };
}
