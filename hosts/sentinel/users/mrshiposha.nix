{ household, ... }:
{
	users.users.mrshiposha = {
		isNormalUser = true;
		description = "Daniel Shiposha";
		extraGroups = [ "wheel" ];
	};

	home-manager.users.mrshiposha = {
		imports = [ household.modules.user ];
		preset.mrshiposha.enable = true;
	};
}
