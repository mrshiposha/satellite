{ config, lib, ... }:
{
	users.users.wally = {
		isNormalUser = true;
		description = "Valentina Shiposha";
	};

	home-manager.users.wally = {
		imports = builtins.map lib.household.common.user [
			/modules
			/programs/fundamental
		];

		theming.gui.wallpapers = {
			active = lib.household.image /1920x1080/nord_mountains.png;
			screensaver = lib.household.image /1920x1080/nord_waves.png;
		};

		connections = {
			telegram.enable = true;
			discord.enable = true;
		};

		home.stateVersion = config.system.stateVersion;
	};
}
