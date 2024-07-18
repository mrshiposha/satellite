lib:
{ ... }:
{
  system = "x86_64-linux";

  modules =
    builtins.map lib.household.common.system [
      /fundamental

      /basic/audio.nix
      /basic/powersave.nix
      /basic/gui.nix
      /basic/games.nix

      /dev/containers.nix
    ]
    ++ [
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
          nix.extraOptions = "   builders-use-substitutes = true\n   cores = 12\n";

          gui = {
            enable = true;
            greeter.seat0.theme = lib.household.greeterThemeFromUserTheme config.home-manager.users.mrshiposha;
          };
        }
      )
    ];
}
