{ pkgs, ... }:
{
	imports = [
		./boot.nix
		./fonts.nix
		./net.nix
		# ./audio.nix
		# ./docker.nix
		# ./powersave.nix
		./security.nix
		# ./gui.nix
		# ./games.nix
		# ./erp.nix
		./unfree.nix
	];

	system.stateVersion = "23.11";

	hardware.enableRedistributableFirmware = true;

	i18n.defaultLocale = "en_US.UTF-8";

	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestions.enable = true;
	};
	users.defaultUserShell = pkgs.zsh;
}
