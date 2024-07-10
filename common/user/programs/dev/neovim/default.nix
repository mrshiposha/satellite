{ pkgs, ... }: {
  programs.neovim =
  let
    dofile = name: ''dofile("${./lua}/${name}.lua")'';
  in {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      nvim-notify 
      noice-nvim
      nordic-nvim
      transparent-nvim
      vim-visual-multi
      flatten-nvim
      tabby-nvim
      nvim-tree-lua
      telescope-nvim
      nvim-web-devicons
      auto-session
      gitsigns-nvim
    ];
    extraLuaConfig = ''
      ${dofile "options"}
      ${dofile "treesitter"}
      ${dofile "telescope"}
      ${dofile "appearance"}
      ${dofile "keymap"}
      ${dofile "terminal"}
      ${dofile "nav"}
      ${dofile "sessions"}
      ${dofile "git"}
    '';
    extraPackages = with pkgs; [ 
	ripgrep
	fd 
    ];

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  xdg.configFile.neovide = {
    target = "neovide/config.toml";
    text = ''
	[font]
	    normal = ["monospace"]
	    size = 15.5
	    hinting = "slight"
	    edging = "subpixelantialias"

	maximized = false
    '';
  };
}
