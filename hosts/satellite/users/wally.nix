{ lib, ... }:
{
	users.users.wally = {
		isNormalUser = true;
		description = "Valentina Shiposha";
	};

	home-manager.users.wally = {
		imports = [ lib.household.modules.user ];

		theming.gui.wallpapers = {
			active = lib.household.image /1920x1080/nord_mountains.png;
			screensaver = lib.household.image /1920x1080/nord_waves.png;
		};

		preset.regularUser.enable = true;
		stats.batsignal = true;
	};
}
