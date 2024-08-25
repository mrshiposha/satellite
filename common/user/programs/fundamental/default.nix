{ pkgs, ... }:
{
	home.packages = with pkgs; [
		pavucontrol
		pamixer
		brightnessctl
		qalculate-gtk
		xdg-utils
	];
}
