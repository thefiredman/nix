{ config, domain, ... }:
let domainId = "git";
in {
  services = {
    gitea = {
      enable = true;
      settings = {
        server = {
          HTTP_PORT = 8097;
          ROOT_URL = "https://${domainId}.${domain}";
          SSH_PORT = 6967;
          DISABLE_SSH = false;
          DOMAIN = "${domainId}.${domain}";
          SSH_DOMAIN = "${domain}";
        };

        session.COOKIE_SECURE = true;
        service.DISABLE_REGISTRATION = false;
      };
    };

    openssh = {
      ports = [ config.services.gitea.settings.server.SSH_PORT ];
    };

    caddy.virtualHosts."${domainId}.${domain}" = {
      extraConfig = ''
        reverse_proxy localhost:${
          builtins.toString config.services.gitea.settings.server.HTTP_PORT
        }
      '';
    };
  };

  networking.firewall.allowedTCPPorts = [
    config.services.gitea.settings.server.HTTP_PORT
    config.services.gitea.settings.server.SSH_PORT
  ];

  environment.persistence."/persist".directories =
    [ config.services.gitea.stateDir ];
}
