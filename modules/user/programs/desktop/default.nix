{ config, lib, ... }:
with lib;
{
	imports = [
		./compositor
		./waybar
		./mako.nix
		./rofi
	];

	options.desktop.enable = mkEnableOption "desktop";

	config = {
		compositor.enable = mkDefault config.desktop.enable;
		waybar.enable = mkDefault config.desktop.enable;
		mako.enable = mkDefault config.desktop.enable;
		rofi.enable = mkDefault config.desktop.enable;
	};
}
