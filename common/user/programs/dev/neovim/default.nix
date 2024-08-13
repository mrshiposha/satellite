{ pkgs, ... }:
{
	programs.neovim =
		let
			dofile = name: ''dofile("${./lua}/${name}.lua")'';
		in
		{
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
				nvim-surround
				lazygit-nvim
				direnv-vim
				trouble-nvim
				rustaceanvim
				actions-preview-nvim
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
				${dofile "lsp"}
			'';
			extraPackages = with pkgs; [
				ripgrep
				fd
				lazygit
				delta
			];

			viAlias = true;
			vimAlias = true;
			vimdiffAlias = true;
		};

	home.packages = with pkgs; [
		luaformatter
		rust-analyzer
		lua-language-server
		nil
	];

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
