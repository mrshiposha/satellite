{ pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      font-awesome
      iosevka
      meslo-lgs-nf
      (nerdfonts.override {
        fonts = [
          "Iosevka"
          "IosevkaTerm"
        ];
      })
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Iosevka Nerd Font"];
        sansSerif = ["Iosevka Nerd Font"];
        monospace = ["IosevkaTerm Nerd Font"];
      };
    };
    fontDir.enable = true;
  };
}
