{ pkgs, ... }: {
  services.greetd = {
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

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [ mesa libva libvdpau ];
    };
  };

  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
    spice-autorandr.enable = true;
    spice-webdavd.enable = true;
  };

  security.sudo.wheelNeedsPassword = false;
  users.users.dashalev = { shell = pkgs.fish; };

  fonts = {
    packages = with pkgs;
      [ (nerdfonts.override { fonts = [ "IosevkaTerm" ]; }) ];
  };
}
