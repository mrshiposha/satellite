{ config
, lib
, pkgs
, ...
}:
with lib;
with types;
let
	cfg = config.gui;
in
{
	options.gui = {
		enable = mkEnableOption "GUI";

		games.enable = mkEnableOption "games";

		greeter.seat0.theme = {
			wallpaper = mkOption { type = path; };

			style = {
				package = mkOption { type = package; };

				name = mkOption { type = str; };
			};

			cursors = {
				package = mkOption { type = package; };

				name = mkOption { type = str; };

				size = mkOption { type = number; };
			};

			icons = {
				package = mkOption { type = package; };

				name = mkOption { type = str; };
			};
		};
	};

	config =
		let
			greeterTheme = cfg.greeter.seat0.theme;
		in
		mkMerge [
			(mkIf cfg.enable {
				audio.enable = mkDefault true;

				programs = {
					hyprland.enable = true;
					wshowkeys.enable = true;
				};

				environment.systemPackages = with pkgs; [
					greeterTheme.style.package
					greeterTheme.cursors.package
					greeterTheme.icons.package

					libsForQt5.qt5.qtwayland
					qt6.qtwayland
				];

				programs.regreet = {
					enable = true;
					settings = {
						background = {
							path = greeterTheme.wallpaper;
							fit = "Contain";
						};

						GTK = {
							theme_name = greeterTheme.style.name;
							cursor_theme_name = greeterTheme.cursors.name;
							icon_theme_name = greeterTheme.icons.name;
						};
					};
				};

				security.pam.services.swaylock = {};

				systemd = {
					user.services.polkit-gnome-authentication-agent-1 = {
						description = "polkit-gnome-authentication-agent-1";
						wantedBy = [ "graphical-session.target" ];
						wants = [ "graphical-session.target" ];
						after = [ "graphical-session.target" ];
						serviceConfig = {
							Type = "simple";
							ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
							Restart = "on-failure";
							RestartSec = 1;
							TimeoutStopSec = 10;
						};
					};
				};
			})

			(mkIf config.laptop.enable {
				services.logind.lidSwitch = "suspend-then-hibernate";
				systemd.sleep.extraConfig = ''
					HibernateDelaySec = 600
				'';
			})

			(mkIf cfg.games.enable {
				programs = {
					steam = {
						enable = true;
						extraPackages = with pkgs; [
							mangohud
							# TODO obs-studio-plugins.obs-vkcapture
						];
					};
					gamemode.enable = true;
				};

				unfree.list = with pkgs; [
					steam
					steamPackages.steam
					steam-run
				];

				hardware.opengl = {
					driSupport = true;
					driSupport32Bit = true;
				};

				environment.systemPackages = with pkgs; [
					(lutris.override {
						extraPkgs = pkgs: [
							wineWowPackages.stable
							wine
							(wine.override { wineBuild = "wine64"; })
							wine64
							wineWowPackages.staging
							winetricks
							wineWowPackages.waylandFull
						];
					})
				];
			})
		];
}
