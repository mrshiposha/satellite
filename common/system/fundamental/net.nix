{
	networking = {
		hostName = "satellite";
		useNetworkd = true;
		wireless.iwd.enable = true;
		nameservers = [
			"1.1.1.1"
			"8.8.8.8"
		];
	};

	systemd.network.enable = true;
	services.automatic-timezoned.enable = true;

	services.openssh.enable = true;
}
