{ pkgs, ... }: {
  environment.shellAliases = {
    upgrade = "sudo nixos-rebuild switch --flake /mnt/hgfs/nix/";
    bootgrade = "sudo nixos-rebuild build --flake /mnt/hgfs/nix/";
    update = "nix flake update";
  };

  hardware = { graphics.enable = true; };

  users.users.dashalev = { shell = pkgs.fish; };

  services = {
    ofono.enable = true;
    openssh.enable = true;

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

  fonts = {
    packages = with pkgs;
      [ (nerdfonts.override { fonts = [ "CascadiaCode" "IosevkaTerm" ]; }) ];
  };
}
