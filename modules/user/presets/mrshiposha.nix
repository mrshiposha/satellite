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
		helix.enable = mkDefault true;
		vscode.enable = mkDefault nixosConfig.gui.enable;
		logseq.enable = mkDefault false;
		connections = {
			mattermost.enable = mkDefault nixosConfig.gui.enable;
			matrix.enable = mkDefault nixosConfig.gui.enable;
			skype.enable = mkDefault nixosConfig.gui.enable;
		};

		firefox.addons = [
			"grammarly-1"
			"polkadot-js-extension"
			"ether-metamask"
		];

		programs = {
			zsh.initExtra = ''
				function navigate() {
					echo "Navigating the fleet...\n" && sudo -u navigator $*
				}
			'';

			git = {
				enable = mkDefault true;
				package = pkgs.gitFull;
				userName = "Daniel Shiposha";
				userEmail = "dev@shiposha.com";
				extraConfig = {
					safe.directory = ["/household"];
				};
			};

			direnv = {
				enable = mkDefault true;
				nix-direnv.enable = mkDefault true;
			};
		};

		home.packages = with pkgs; mkMerge [
			(mkIf cfg.imageUtils.enable [
				qrencode
				inkscape
			])
			[coturn jq fx]
		];
	};
}
