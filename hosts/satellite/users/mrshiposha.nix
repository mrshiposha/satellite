{ config
, lib
, pkgs
, ...
}:
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
			/programs/dev/vscode.nix
			/programs/dev/neovim
			/programs/dev/lazygit.nix
		];

		theming.gui.wallpapers = {
			active = lib.household.image /1920x1080/nord_mountains.png;
			screensaver = lib.household.image /1920x1080/nord_waves.png;
		};

		firefox.enable = true;
		wezterm.enable = true;
		stats = {
			enable = true;
			batsignal = true;
		};
		yazi.enable = true;
		zathura.enable = true;
		logseq.enable = true;

		connections = {
			telegram.enable = true;
			discord.enable = true;
			mattermost.enable = true;
		};


		home.packages = with pkgs; [
			qrencode
			inkscape
			neovide
			ghidra-bin
		];

		programs = {
			git = {
				enable = true;
				userName = "Daniel Shiposha";
				userEmail = "ds@unique.network";
			};

			direnv = {
				enable = true;
				nix-direnv.enable = true;
			};
		};

		home.stateVersion = config.system.stateVersion;
	};
}
