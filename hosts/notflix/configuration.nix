{ pkgs, ... }: {
  services = {
    greetd = {
      enable = true;
      restart = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.river}/bin/river";
          user = "dashalev";
        };
        default_session = initial_session;
      };
    };
  };

  environment.systemPackages = with pkgs; [ vesktop qbittorrent ];

  security.sudo.wheelNeedsPassword = false;
  users.users.dashalev = { shell = pkgs.fish; uid = 1000; };

  fonts = {
    packages = with pkgs;
      [ (nerdfonts.override { fonts = [ "CascadiaCode" ]; }) ];
  };
}
