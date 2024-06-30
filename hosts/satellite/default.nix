lib: { ... }: {
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

      ({ config, ... }: {
        gui = {
          enable = true;
          greeter.seat0.theme = lib.household.greeterThemeFromUserTheme
            config.home-manager.users.mrshiposha;
        };
      })
  ];
}
