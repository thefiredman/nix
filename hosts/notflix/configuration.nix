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

  security.sudo.wheelNeedsPassword = false;
  users.users.dashalev = { shell = pkgs.fish; };

  fonts = {
    packages = with pkgs;
      [ (nerdfonts.override { fonts = [ "IosevkaTerm" ]; }) ];
  };
}
