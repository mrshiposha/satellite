{ config, lib, ... }:
let
  usersFonts = builtins.concatMap (
    theming:
    theming.fonts.packages
    ++ (if theming.fonts.defaults.enable then theming.fonts.defaults.packages else [ ])
  ) (lib.household.userModulesByName config "theming");
in
{
  fonts = {
    packages = usersFonts;
    fontDir.enable = true;
  };
}
