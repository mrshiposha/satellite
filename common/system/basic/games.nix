{ pkgs, ... }:
{
	programs = {
		steam = {
			enable = true;
			extraPackages = with pkgs; [
				mangohud
				# TODO obs-studio-plugins.obs-vkcapture
			];
		};
		gamemode.enable = true;
	};

	unfree.list = with pkgs; [
		steam
		steamPackages.steam
		steam-run
	];

	hardware.opengl = {
		driSupport = true;
		driSupport32Bit = true;
	};

	environment.systemPackages = with pkgs; [
		(lutris.override {
			extraPkgs = pkgs: [
				wineWowPackages.stable
				wine
				(wine.override { wineBuild = "wine64"; })
				wine64
				wineWowPackages.staging
				winetricks
				wineWowPackages.waylandFull
			];
		})
	];
}
