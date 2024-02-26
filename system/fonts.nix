{ pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      font-awesome
      meslo-lgs-nf
      mononoki
      iosevka
    ];
    fontconfig = {
      enable = true;
      defaultFonts.monospace = ["MesloLGS NF"];
    };
    fontDir.enable = true;
  };
}
