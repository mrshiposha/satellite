{ pkgs, ... }: with pkgs; {
  home.packages = [
    tdesktop
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