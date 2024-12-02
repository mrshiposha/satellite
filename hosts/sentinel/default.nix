options: {
  system = "x86_64-linux";

  nixos.imports = [
    ./hardware-configuration.nix
    ./users

    (
			{ config, household, ... }:
			{
				networking.hostName = "sentinel";

        networking.interfaces.enp3s0 = {
          ipv6.addresses = options.ip.addr.v6;
          ipv4.addresses = options.ip.addr.v4;
        };

				# nix.buildMachines = [
				# 	{
				# 		hostName = "hearthstone";
				# 		system = "x86_64-linux";
				# 		protocol = "ssh-ng";
				# 		sshUser = "nix-remote";
				# 		sshKey = "/root/.ssh/buildhost/hearthstone/id_ecdsa";
				# 		maxJobs = 16;
				# 		speedFactor = 10;
				# 		supportedFeatures = [
				# 			"kvm"
				# 			"big-parallel"
				# 		];
				# 	}
				# ];
				# nix.distributedBuilds = true;

				# nix.extraOptions = ''
				# 	builders-use-substitutes = true
				# 	cores = 4
				# '';

				intel.enable = true;
			}
		)
  ];
}
