{ pkgs, inputs, lib, config, ... }: {
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  time.timeZone = "Canada/Eastern";

  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";
    shellAliases = {
      upgrade =
        "sudo nixos-rebuild switch --flake ${config.genesis.nixConfigDir}";
      bootgrade =
        "sudo nixos-rebuild build --flake ${config.genesis.nixConfigDir}";
      update = "nix flake update --flake ${config.genesis.nixConfigDir}";
    };
  };

  nix = {
    package = pkgs.nixVersions.latest;
    registry.nixpkgs.flake = inputs.nixpkgs;
    channel.enable = false;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "cgroups"
        "auto-allocate-uids"
        "fetch-closure"
      ];
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
  security = {
    rtkit.enable = config.services.pipewire.enable;
    polkit.enable = true;
  };

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
    command-not-found.enable = false;
    dconf = { inherit (config.hardware.graphics) enable; };
    git = {
      enable = true;
      lfs.enable = true;
    };
  };

  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
  };

  environment = {
    systemPackages = with pkgs; [ usbutils pciutils file ];
    persistence."/persist" = { directories = [ "/var/lib/NetworkManager/" "/var/lib/nixos/" ]; };
  };

  hardware.pulseaudio.enable = lib.mkForce false;
  services = {
    dbus.implementation = "broker";
    openssh.enable = true;
    rsyncd.enable = true;
  };

  system = { stateVersion = lib.mkForce "24.05"; };
}
