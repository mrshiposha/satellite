{ config, lib, ... }:
with lib;
with lib.types;
let
	extensionUrl =
		name: version: "https://addons.mozilla.org/firefox/downloads/latest/${name}/${version}.xpi";
in
{
	options.firefox = {
		enable = mkEnableOption "firefox";
		defaultPdfApp = mkOption {
			type = bool;
			default = false;
		};
	};

	config = mkIf config.firefox.enable {
		programs.firefox = {
			enable = true;
			policies = {
				DisableTelemetry = true;

				Preferences = {
					xpinstall.signatures.required = false;
				};

				Extensions = {
					Install = [
						(extensionUrl "grammarly-1" "latest")
						(extensionUrl "polkadot-js-extension" "latest")
						(extensionUrl "ether-metamask" "latest")
					];
				};
			};
		};

		xdg.mimeApps.defaultApplications."application/pdf" = mkIf
			config.firefox.defaultPdfApp
			[ "firefox.desktop" ];
	};
}
