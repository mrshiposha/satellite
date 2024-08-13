{ config, lib, ... }:
{
	users.users.wally = {
		isNormalUser = true;
		description = "Valentina Shiposha";
	};

	home-manager.users.wally = {
		imports = builtins.map lib.household.common.user [
			/modules/basic
			/programs/fundamental
			/programs/basic
		];

		theming.gui.wallpapers = {
			active = lib.household.image /1920x1080/nord_mountains.png;
			screensaver = lib.household.image /1920x1080/nord_waves.png;
		};

		home.stateVersion = config.system.stateVersion;
	};
}
