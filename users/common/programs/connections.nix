{ pkgs, ... }: {
  home.packages = with pkgs; [
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
