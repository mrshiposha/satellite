{ pkgs, ... }: {
  programs.neovim =
  let
    dofile = name: ''dofile("${./lua}/${name}.lua")'';
  in {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      nordic-nvim
      vim-visual-multi
      chadtree
      flatten-nvim
      toggleterm-nvim
      barbar-nvim
      plenary-nvim
      telescope-nvim
      telescope-media-files-nvim
      nvim-web-devicons
      auto-session
      gitsigns-nvim
    ];
    extraLuaConfig = ''
      ${dofile "options"}
      ${dofile "keymap"}
      ${dofile "theme"}
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

  home.packages = with pkgs; [
    ripgrep
    fd 
  ];
}
