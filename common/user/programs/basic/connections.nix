{ pkgs, ... }:
{
  home.packages = with pkgs; [
		tdesktop
		discord
		mattermost-desktop
	];

	unfree.list = with pkgs; [
		discord
	];
}
