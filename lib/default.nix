{
	household = {
		modules.system = ../modules/system;
		modules.user = ../modules/user;
		image = path: ../images + path;

		userModulesByName =
			config: moduleName:
			let
				users = builtins.attrValues config.home-manager.users;
			in
			builtins.map (user: user.${moduleName}) (builtins.filter (user: builtins.hasAttr "${moduleName}" user) users);

		greeterThemeFromUserTheme =
			user:
			let
				theming = user.theming.gui;
			in
			{
				wallpaper = theming.wallpapers.screensaver;
				style = theming.style;
				cursors = theming.cursors;
				icons = theming.icons;
			};
	};
}
