{ pkgs, ... }: {
  programs.neovim =
  let
    dofile = name: ''dofile("${./lua}/${name}.lua")'';
  in {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      nordic-nvim
      transparent-nvim
      vim-visual-multi
      neo-tree-nvim
      flatten-nvim
      barbar-nvim
      plenary-nvim
      telescope-nvim
      telescope-media-files-nvim
      nvim-web-devicons
      auto-session
      gitsigns-nvim
    ];
    extraLuaConfig = ''
      ${dofile "appearance"}
      ${dofile "options"}
      ${dofile "keymap"}
      ${dofile "terminal"}
      ${dofile "nav"}
      ${dofile "telescope"}
      ${dofile "sessions"}
      ${dofile "git"}
    '';

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  xdg.configFile.neovide = {
    target = "neovide/config.toml";
    text = ''
      maximized = false
    '';
  };

  home.packages = with pkgs; [
    ripgrep
    fd 
  ];
}
