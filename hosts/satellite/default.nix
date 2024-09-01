lib:
{ ... }:
{
	system = "x86_64-linux";

	modules = [
		./hardware-configuration.nix
		./users

		(
			{ config, ... }:
			{
				nix.buildMachines = [
					{
						hostName = "hearthstone";
						system = "x86_64-linux";
						protocol = "ssh-ng";
						sshUser = "nix-remote";
						sshKey = "/root/.ssh/buildhost/hearthstone/id_ecdsa";
						maxJobs = 16;
						speedFactor = 10;
						supportedFeatures = [
							"kvm"
							"big-parallel"
						];
					}
				];
				nix.distributedBuilds = true;

				nix.extraOptions = ''
					builders-use-substitutes = true
					cores = 12
				'';

				laptop.enable = true;
				intel.enable = true;

				gui = {
					enable = true;
					greeter.seat0.theme = lib.household.greeterThemeFromUserTheme config.home-manager.users.mrshiposha;
				};

				container-mgmt.enable = true;
			}
		)
	];
}
