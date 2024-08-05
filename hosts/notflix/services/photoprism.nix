{ domain, config, pkgs, ... }: {
  services = {
    photoprism = {
      enable = true;
      package = pkgs.stable.photoprism;
      port = 8099;
      originalsPath = "/mnt/b/media/photos/";
    };

    caddy.virtualHosts."photos.${domain}" = {
      extraConfig = ''
        reverse_proxy localhost:${
          builtins.toString config.services.photoprism.port
        }
      '';
    };
  };

  networking.firewall.allowedTCPPorts = [ config.services.photoprism.port ];
}
