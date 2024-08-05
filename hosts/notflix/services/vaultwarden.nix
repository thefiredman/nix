{ config, domain, ... }: {
  services = {
    vaultwarden = {
      enable = true;
      config = { ROCKET_PORT = 8098; };
    };

    caddy.virtualHosts = {
      "auth.${domain}" = {
        extraConfig = ''
          reverse_proxy localhost:${
            builtins.toString config.services.vaultwarden.config.ROCKET_PORT
          }
        '';
      };
    };
  };

  networking.firewall.allowedTCPPorts =
    [ config.services.vaultwarden.config.ROCKET_PORT ];

  environment.persistence."/persist" = {
    directories = [ "/var/lib/vaultwarden/" "/var/lib/bitwarden_rs/" ];
  };
}
