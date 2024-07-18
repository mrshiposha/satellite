{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tdesktop
    slack
    discord
  ];

  unfree.list = with pkgs; [
    slack
    discord
  ];

  programs = {
    thunderbird = {
      enable = true;
      profiles = {
        basic.isDefault = true;
      };
    };
  };
}
