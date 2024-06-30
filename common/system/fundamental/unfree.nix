{ config, lib, ... }: with lib;
let
  cfg = config.unfree;
in {
  options = {
    unfree.list = with types; mkOption {
      type = listOf package;
    };
  };

  config = let
    usersFullUnfreeList = builtins.concatMap
      (unfree: unfree.list)
      (lib.household.userModulesByName config "unfree");
    fullUnfreeList = cfg.list ++ usersFullUnfreeList;
  in {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem
        (lib.getName pkg)
        (builtins.map (listedPkg: (lib.getName listedPkg)) fullUnfreeList);
  };
}
