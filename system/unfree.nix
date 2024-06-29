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
    users = builtins.attrValues config.home-manager.users;
    usersFullUnfreeList = (
        builtins.concatMap
          (user: user.unfree.list)
          (builtins.filter (user: user ? unfree) users)
      );
    fullUnfreeList = cfg.list ++ usersFullUnfreeList;
  in {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem
        (lib.getName pkg)
        (builtins.map (listedPkg: (lib.getName listedPkg)) fullUnfreeList);
  };
}
