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
      nvim-web-devicons
    ];
    extraLuaConfig = ''
      ${dofile "options"}
      ${dofile "keymap"}
      ${dofile "theme"}
      ${dofile "terminal"}
      ${dofile "nav"}
      ${dofile "telescope"}
      ${dofile "dashboard"}
    '';

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
