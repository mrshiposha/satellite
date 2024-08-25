{ config, lib, pkgs, ... }:
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
		preset.regularUser.enable = true;
		yazi.enable = true;

		neovim.enable = true;
		logseq.enable = true;
		connections.mattermost.enable = true;

		programs = {
			git = {
				enable = true;
				userName = "Daniel Shiposha";
				userEmail = "ds@unique.network";
			};

			direnv = {
				enable = true;
				nix-direnv.enable = true;
			};
		};

		home.packages = with pkgs; mkIf cfg.imageUtils.enable [
			qrencode
			inkscape
		];
	};
}
