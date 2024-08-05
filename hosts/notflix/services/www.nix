{ domain, ... }: {
  services.caddy.virtualHosts = {
    "${domain}" = {
      extraConfig = ''
        root /var/www/${domain}
        file_server
      '';
    };
  };

  environment.persistence."/persist".directories = [ "/var/www" ];
}
