{ nixosConfig, config, pkgs, lib, ... }:
with lib;
let
	cfg = config.preset.regularUser;
in
{
	options.preset.regularUser.enable = mkEnableOption "regular user preset";

	config = mkIf cfg.enable {
		zsh.enable = mkDefault true;

		crypto.enable = mkDefault true;

		desktop.enable = mkDefault nixosConfig.gui.enable;
		wezterm.enable = mkDefault nixosConfig.gui.enable;
		firefox.enable = mkDefault nixosConfig.gui.enable;
		stats.enable = mkDefault nixosConfig.gui.enable;
		zathura.enable = mkDefault nixosConfig.gui.enable;
		connections = {
			telegram.enable = mkDefault nixosConfig.gui.enable;
			discord.enable = mkDefault nixosConfig.gui.enable;
		};

		home.packages = with pkgs; mkMerge [
			( mkIf nixosConfig.gui.enable [ xdg-utils ] )
			[ trash-cli ]
		];

		xdg.mimeApps.enable = mkDefault nixosConfig.gui.enable;
		home.stateVersion = nixosConfig.system.stateVersion;
	};
}
