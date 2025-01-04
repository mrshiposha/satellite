{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.services."shiposha.com";
  zitadelPort = 60110;
  zitadelDbAdminUser = "zitadel_admin";
  zitadelHome = "/home/zitadel";
  zitadelSecrets = "${zitadelHome}/secrets";
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
          default = true;
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
          locations."/".extraConfig = ''
            grpc_pass grpc://localhost:${builtins.toString zitadelPort};
            grpc_set_header Host $host;
          '';
        };
      };
    };

    services.db = {
      enable = true;

      users.${zitadelDbAdminUser} = {
        passwordFile = config.secrets.zitadel.secret.path;
      };

      postInitScript = pkgs.writeText "db-init-script" ''
        ALTER USER ${zitadelDbAdminUser} CREATEROLE CREATEDB;
      '';
    };

    users.users.zitadel = {
      isSystemUser = true;
      createHome = true;
      home = zitadelHome;
      group = "zitadel";
    };
    users.groups.zitadel = {};
    systemd.services.zitadel-setup =
    let
      secretPattern = "@ZITADEL_PASSWORD@";
      secretTemplate = (pkgs.formats.yaml {}).generate "secret-template.yaml" {
        Database.postgres = {
          User = {
            Username = "zitadel";
            Password = secretPattern;
            SSL.Mode = "disable";
          };

          Admin = {
            Username = zitadelDbAdminUser;
            Password = secretPattern;
            SSL.Mode = "disable";
          };
        };
      };
    in {
      wantedBy = [ "multi-user.target" ];
      before = [ "zitadel.service" ];
      serviceConfig = {
        Type = "oneshot";
        User = "zitadel";
      };
      path = with pkgs; [ replace-secret ];
      script = ''
        cp ${secretTemplate} ${zitadelSecrets}
        chmod 600 ${zitadelSecrets}
        replace-secret ${secretPattern} ${config.secrets.zitadel.secret.path} ${zitadelSecrets}
      '';
    };

    services.zitadel = {
      enable = true;
      tlsMode = "external";
      settings = {
        ExternalDomain = "id.shiposha.com";
        ExternalPort = 443;
        ExternalSecure = true;
        Port = zitadelPort;
        TLS.Enabled = false;

        Database.postgres = {
          Host = "localhost";
          Port = config.services.db.port;
          Database = "zitadel";
        };
      };
      extraSettingsPaths = [zitadelSecrets];
      steps = let orgName = "Shiposha Family Services"; in {
        FirstInstance = {
          InstanceName = orgName;
          Org = {
            Name = orgName;
            Human = {
              UserName = "daniel@shiposha.com";
              Password = "3eIn!tial:Pass";
              FirstName = "Daniel";
              LastName = "Shiposha";
            };
          };
        };
      };
      masterKeyFile = config.secrets.zitadel.secret.path;
    };
  };
}
