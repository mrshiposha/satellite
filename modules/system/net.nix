{ config, lib, ... }:
with lib;

let
	cfg = config.net;
in
{
	options.net = {
		wireless.enable = mkEnableOption "wireless networking";
		ssh.enable = mkEnableOption "ssh";
	};

	config = {
		networking = {
			useNetworkd = true;
			wireless.iwd.enable = cfg.wireless.enable;
			nameservers = [
				"1.1.1.1"
				"8.8.8.8"
			];
		};

		systemd.network.enable = true;
		services.automatic-timezoned.enable = true;

		services.openssh = {
			enable = cfg.ssh.enable;
			settings = {
				PasswordAuthentication = false;
				PermitRootLogin = "no";
				LogLevel = "VERBOSE";
			};
		};

		services.fail2ban.enable = cfg.ssh.enable;
	};
}
