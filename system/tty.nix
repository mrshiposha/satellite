{ pkgs, ... }: {
  services.kmscon = {
    enable = true;
    hwRender = true;
    fonts = [
      {
        name = "IosevkaTerm Nerd Font";
        package = pkgs.nerdfonts.override {
          fonts = ["IosevkaTerm"];
        };
      }
    ];
  };
}
