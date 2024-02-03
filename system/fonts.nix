{ pkgs, ... }: with pkgs; {
  fonts = {
    packages = [
      font-awesome
      meslo-lgs-nf
      mononoki
    ];
    fontconfig = {
      enable = true;
      defaultFonts.monospace = ["MesloLGS NF"];
    };
    fontDir.enable = true;
  };
}
