{ pkgs, ... }: with pkgs; {
  environment.systemPackages = [
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
  ];
}
