{ pkgs, household, ... }: {
  users.users.navigator = {
    description = "fleet navigator";
    isNormalUser = true;
    group = "wheel";
    shell = pkgs.zsh;
    hashedPassword = "!";
  };
  security.sudo.extraConfig = ''
    navigator ALL=(ALL) NOPASSWD:ALL
  '';
  home-manager.users.navigator = {
    imports = [ household.modules.user ];

    home.stateVersion = "23.11";
    zsh.enable = true;
    programs = {
      git.enable = true;
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
  
}
