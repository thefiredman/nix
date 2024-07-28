{ lib, config, ... }: {
  services.nix-daemon.enable = true;
  security.pam.enableSudoTouchIdAuth = true;

  environment.shellAliases = {
    upgrade = "darwin-rebuild switch --flake ~/nix#${config.genesis.hostName}";
    bootgrade = "darwin-rebuild build --flake ~/nix#${config.genesis.hostName}";
    update = "nix flake update ~/nix";
  };

  system = { stateVersion = lib.mkForce 4; };
}
