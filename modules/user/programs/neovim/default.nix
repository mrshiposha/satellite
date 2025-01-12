{ config, pkgs, lib, ... }:
with lib;
{
	options.neovim.enable = mkEnableOption "neovim";

	config = mkIf config.neovim.enable {
		lazygit.enable = mkDefault true;

		programs.neovim = {
			enable = true;
			defaultEditor = true;
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

		home.packages = with pkgs; mkMerge [
			[
				gcc
				lldb
				nodejs_22
				python39
				luaformatter
				rust-analyzer
				lua-language-server
				nodePackages.typescript-language-server
				nil
			]
		];

    xdg.configFile.nvim = {
      recursive = true;
      source = pkgs.fetchFromGitLab {
        owner = "gabmus";
        repo = "nvpunk";
        rev = "b6356fe1ded4a063ea30220d78f47008d2ad8d31";
        sha256 = "sha256-hX1DyYKPDn4Lur9lSuHtfX/ChJnSunEHwEnMJe09PGU=";
      };
    };
    xdg.configFile.nvpunk-prefs = {
      target = "nvim/org.gabmus.nvpunk.preferences.json";
      source = ./org.gabmus.nvpunk.preferences.json;
    };
	};	
}
