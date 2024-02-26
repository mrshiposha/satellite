{ nixosConfig, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      tamasfe.even-better-toml
      matklad.rust-analyzer
      vadimcn.vscode-lldb
      dbaeumer.vscode-eslint
      jnoortheen.nix-ide
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "nord-visual-studio-code";
        publisher = "arcticicestudio";
        version = "0.19.0";
        sha256 = "sha256-awbqFv6YuYI0tzM/QbHRTUl4B2vNUdy52F4nPmv+dRU=";
      }

      {
        name = "markdown-preview-enhanced";
        publisher = "shd101wyy";
        version = "0.6.8";
        sha256 = "sha256-9NRaHgtyiZJ0ic6h1B01MWzYhDABAl3Jm2IUPogYWr0=";
      }

      {
        name = "jsonnet";
        publisher = "heptio";
        version = "0.1.0";
        sha256 = "sha256-AwiVkUNyKTTCzzsS0XoQRFeW/e+iOsXxeLANi8/kEdQ=";
      }

      {
        name = "pest-ide-tools";
        publisher = "pest";
        version = "0.3.6";
        sha256 = "sha256-oyT/O0LwOCVVKM0JGiWTcRVXBElDplcZ+m1Eq+bRTJA=";
      }
    ];
    userSettings = {
      terminal.integrated.fontFamily = builtins.elemAt
        nixosConfig.fonts.fontconfig.defaultFonts.monospace
        0;
      
      files.insertFinalNewline = true;
      editor.fontFamily = "iosevka";
      window.zoomLevel = 1.5;
      window.menuBarVisibility = "toggle";

      pestIdeTools.serverPath = "${pkgs.pest-ide-tools}/bin/pest-language-server";

      nix = {
        enableLanguageServer = true;
        serverPath = "nil";
        serverSettings = {
          nil.formatting.command = ["nixpkgs-fmt"];
        };
      };

      lldb.suppressUpdateNotifications = true;
      workbench.colorTheme = "Nord";
    };
  };

  home.packages = with pkgs; [
    nil
    nixpkgs-fmt
  ];

}
