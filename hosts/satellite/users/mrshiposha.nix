{ household, ... }:
{
	users.users.mrshiposha = {
		isNormalUser = true;
		description = "Daniel Shiposha";
		extraGroups = [
			"wheel"
			"podman"
		];
	};

	home-manager.users.mrshiposha = {
		imports = [ household.modules.user ];

		theming.gui.wallpapers = {
			active = household.image /1920x1080/nord_mountains.png;
			screensaver = household.image /1920x1080/nord_waves.png;
		};

		preset.mrshiposha = {
			enable = true;
			imageUtils.enable = true;
		};
		stats.batsignal = true;
	};
}
