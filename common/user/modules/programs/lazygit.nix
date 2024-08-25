{ config, lib, ... }:
with lib;
{
	options.lazygit.enable = mkEnableOption "lazygit";

	config = mkIf config.lazygit.enable {
		programs.lazygit = {
			enable = true;
			settings.keybinding = {
				universal = {
					quit = "<c-q>";
					return = "q";
				};
			};
		};
	};
}
