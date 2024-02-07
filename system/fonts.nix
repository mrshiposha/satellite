{ pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
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
