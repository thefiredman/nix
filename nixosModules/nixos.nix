{ pkgs, inputs, lib, config, ... }: {
  environment.shellAliases = {
    upgrade =
      "sudo nixos-rebuild switch --flake ~/nix#${config.genesis.hostName}";
    bootgrade =
      "sudo nixos-rebuild build --flake ~/nix#${config.genesis.hostName}";
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  nix = {
    package = pkgs.nixVersions.latest;
    registry.nixpkgs.flake = inputs.nixpkgs;
    channel.enable = false;
    settings = {
      experimental-features =
        [ "cgroups" "auto-allocate-uids" "fetch-closure" ];
      nix-path = "nixpkgs=flake:nixpkgs";
      use-cgroups = true;
      auto-allocate-uids = true;
      warn-dirty = false;
      trusted-users = [ "@wheel" ];
      allowed-users = lib.mapAttrsToList (_: u: u.name)
        (lib.filterAttrs (_: user: user.isNormalUser) config.users.users);
    };
  };

  systemd.services.nix-daemon.serviceConfig = { OOMScoreAdjust = 250; };
  security.rtkit.enable = config.services.pipewire.enable;
  services.pipewire = {
    inherit (config.hardware.graphics) enable;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    jack.enable = true;
  };

  programs = {
    dconf = { inherit (config.hardware.graphics) enable; };
    git = {
      enable = true;
      lfs.enable = true;
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  time.timeZone = "Canada/Eastern";
  hardware.pulseaudio.enable = lib.mkForce false;
  services.dbus.implementation = "broker";

  system = { stateVersion = lib.mkForce "24.11"; };
}
