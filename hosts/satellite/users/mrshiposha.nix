{ config, household, ... }:
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

		accounts.email.accounts = {
			dev = {
				primary = true;
				realName = "Daniel Shiposha";
				address = "dev@shiposha.com";
				userName = "dev@shiposha.com";
				passwordCommand = "cat ${config.secrets.dev-email.secret.path}";

				aerc.enable = true;
				smtp = {
					host = "smtp.protonmail.ch";
					port = 587;
				};
			};
		};
	};
}
