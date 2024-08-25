{ lib, ... }:
{
	users.users.mrshiposha = {
		isNormalUser = true;
		description = "Daniel Shiposha";
		extraGroups = [
			"wheel"
			"docker"
		];
	};

	home-manager.users.mrshiposha = {
		imports = builtins.map lib.household.common.user [
			/modules
			/programs/fundamental
		];

		theming.gui.wallpapers = {
			active = lib.household.image /1920x1080/nord_mountains.png;
			screensaver = lib.household.image /1920x1080/nord_waves.png;
		};

		preset.mrshiposha = {
			enable = true;
			imageUtils.enable = true;
		};
		stats.batsignal = true;
	};
}
