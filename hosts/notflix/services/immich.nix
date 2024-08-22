{ config, inputs, domain, ... }: {
  # imports = [ "${inputs.immich}/nixos/modules/services/web-apps/immich.nix" ];
  #
  # services = {
  #   immich = {
  #     package = inputs.immich.legacyPackages.x86_64-linux.immich;
  #     enable = true;
  #     port = 8099;
  #     openFirewall = true;
  #   };
  #
  #   caddy.virtualHosts = {
  #     "immich.${domain}" = {
  #       extraConfig = ''
  #         reverse_proxy localhost:${
  #           builtins.toString config.services.immich.port
  #         }
  #       '';
  #     };
  #   };
  # };

  # networking.firewall.allowedTCPPorts =
  #   [ config.services.immich.port config.services.immich.redis.port ];

  environment = {
    persistence."/persist" = {
      directories = [
        "/var/lib/immich/"
        # config.services.immich.mediaLocation
        "/var/lib/redis-immich/"
        "/run/postgresql/"
        "/var/lib/postgresql/"
      ];
    };
    
    # systemPackages = with inputs.immich.legacyPackages.x86_64-linux; [
    #   immich.cli
    # ];
  };
}
