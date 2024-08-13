{ config, pkgs, lib, ... }:
with lib;

let
	cfg = config.connections;
in
{
	options.connections = {
		telegram.enable = mkEnableOption "telegram";
		discord.enable = mkEnableOption "discord";
		mattermost.enable = mkEnableOption "mattermost";
	};

	config = with pkgs; {
		home.packages = mkMerge [
			( mkIf cfg.telegram.enable [ tdesktop ] )
			( mkIf cfg.discord.enable [ discord ] )
			( mkIf cfg.mattermost.enable [ mattermost-desktop ] )
		];

		unfree.list = with pkgs; mkIf cfg.discord.enable [
			discord
		];
	};

}
