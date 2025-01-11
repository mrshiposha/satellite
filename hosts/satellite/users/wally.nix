{ household, ... }:
{
	users.users.wally = {
		isNormalUser = true;
		description = "Valentina Shiposha";
	};

	home-manager.users.wally = {
		imports = [ household.modules.user ];

		preset.wally.enable = true;

		theming.gui.wallpapers = {
			active = household.image /1920x1080/nord_mountains.png;
			screensaver = household.image /1920x1080/nord_waves.png;
		};

		preset.regularUser.enable = true;
		stats.batsignal = true;
	};
}
