{ config, domain, pkgs, ... }: {
  services = {
    jellyfin = {
      openFirewall = true;
      enable = true;
      user = "dashalev";
    };

    caddy.virtualHosts = {
      "jellyfin.${domain}" = {
        extraConfig = ''
          reverse_proxy localhost:8096
        '';
      };
    };
  };

  networking.firewall = { allowedTCPPorts = [ 8096 ]; };

  environment = {
    persistence."/persist" = {
      directories =
        [ config.services.jellyfin.dataDir config.services.jellyfin.cacheDir ];
    };

    systemPackages = with pkgs; [
      mediainfo
      jellyfin-ffmpeg
      intel-gpu-tools
      jellyfin-media-player
    ];
  };
}
