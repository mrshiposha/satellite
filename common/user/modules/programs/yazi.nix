{ config, lib, ... }:
with lib;
{
	options.yazi.enable = mkEnableOption "yazi";

	config = mkIf config.yazi.enable {
		programs.yazi = {
			enable = true;
			enableZshIntegration = true;
			settings = {
				show_hidden = false;
			};
		};
	};
}
