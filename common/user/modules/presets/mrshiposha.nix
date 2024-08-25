{ nixosConfig, config, lib, pkgs, ... }:
with lib;
let
	cfg = config.preset.mrshiposha;
in
{
	options.preset.mrshiposha = {
		enable = mkEnableOption "mrshiposha user";
		imageUtils.enable = mkEnableOption "image and qr utils";
	};

	config = mkIf cfg.enable {
		preset.regularUser.enable = mkDefault true;
		yazi.enable = mkDefault true;

		neovim.enable = mkDefault true;
		logseq.enable = mkDefault nixosConfig.gui.enable;
		connections.mattermost.enable = mkDefault nixosConfig.gui.enable;

		programs = {
			git = {
				enable = mkDefault true;
				userName = "Daniel Shiposha";
				userEmail = "ds@unique.network";
			};

			direnv = {
				enable = mkDefault true;
				nix-direnv.enable = mkDefault true;
			};
		};

		home.packages = with pkgs; mkIf cfg.imageUtils.enable [
			qrencode
			inkscape
		];
	};
}