{ pkgs, ... }: with pkgs; {
  imports = [
    ./hyprland.nix
    ./rofi.nix
  ];

  home.packages = [
    networkmanagerapplet
  ];
}
