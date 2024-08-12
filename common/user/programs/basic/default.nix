{ pkgs, ... }: {
	imports = [
		./wezterm.nix
		./stats.nix
		./firefox.nix
		./connections.nix
		./yazi.nix
		./zathura.nix
	];

	home.packages = with pkgs; [
		logseq
	];
}
