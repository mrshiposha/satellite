{ pkgs, ... }:
let
    minisurround = pkgs.vimUtils.buildVimPlugin {
	name = "mini.surround";
	src = pkgs.fetchFromGitHub {
	  owner = "echasnovski";
	  repo = "mini.surround";
	  rev = "3cb5b509ad34f2402df4b977be607a614c8c7524";
	  hash = "sha256-0csTosYTbSoGVP7yHJw6rzjoIcCYU5WQoeXMzqdP7Q8=";
	};	
    };
in
{
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
      galaxyline-nvim
      dressing-nvim
      telescope-nvim
      telescope-undo-nvim
      nvim-web-devicons
      auto-session
      gitsigns-nvim
      nvim-cmp
      cmp-buffer
      cmp-path
      cmp-cmdline
      nvim-lspconfig
      cmp-nvim-lsp
      luasnip
      nvim-autopairs
      nvim-comment
      minisurround
      lazygit-nvim
    ];
    extraLuaConfig = ''
      package.path = "${./lua}/?.lua;"..package.path

      ${dofile "options"}
      ${dofile "treesitter"}
      ${dofile "telescope"}
      ${dofile "appearance"}
      ${dofile "keymap"}
      ${dofile "terminal"}
      ${dofile "nav"}
      ${dofile "sessions"}
      ${dofile "git"}
      ${dofile "completion"}
    '';
    extraPackages = with pkgs; [ 
	ripgrep
	fd
	lua-language-server
	nil
	lazygit
    ];

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  home.packages = [ pkgs.luaformatter ];

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
