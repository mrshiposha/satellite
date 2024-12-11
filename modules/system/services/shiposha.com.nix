{ config, lib, ... }:
with lib;

let
  cfg = config.services."shiposha.com";
in
{
  options.services."shiposha.com" = {
    enable = mkEnableOption "shiposha.com service";
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [
      80
      443
    ];
    security.acme = {
      acceptTerms = true;
      defaults.email = "daniel@shiposha.com";
      certs."shiposha.com".extraDomainNames = [
        "id.shiposha.com"
      ];
    };
    services.nginx = {
      enable = true;
      virtualHosts = {
        "shiposha.com" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            return = "200 '<html><body>Temporary Dummy Content</body></html>'";
            extraConfig = ''
              default_type text/html;
            '';
          };
        };

        "id.shiposha.com" = {
          forceSSL = true;
          useACMEHost = "shiposha.com";
          locations."/" = {
            return = "200 '<html><body>ID Domain</body></html>'";
            extraConfig = ''
              default_type text/html;
            '';
          };
        };
      };
    };
  };
}
