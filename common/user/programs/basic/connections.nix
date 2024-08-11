{ pkgs, ... }:
{
  home.packages = with pkgs; [
		tdesktop
		discord
	];

	unfree.list = with pkgs; [
		discord
	];
}
