{ config, lib, ... }:
with lib;
let
	cfg = config.preset.regularUser;
in
{
	options.preset.regularUser.enable = mkEnableOption "regular user preset";

	config = mkIf cfg.enable {
		firefox.enable = mkDefault true;
		wezterm.enable = mkDefault true;
		stats.enable = mkDefault true;
		zathura.enable = mkDefault true;
		connections = {
			telegram.enable = mkDefault true;
			discord.enable = mkDefault true;
		};

		home.stateVersion = "23.11";
	};
}
