{ inputs, config, pkgs, lib, ... }: {
  environment = {
    systemPackages = with pkgs; [
      wget
      rsync
      unzip
      p7zip
      tree
      vimv
      onefetch
      fastfetch
      btop
      htop
      dysk
      bat
      hyperfine
      neovim
    ];

    variables.NIX_CONFIG = "${config.genesis.nixConfig}";
  };

  programs = {
    fish.enable = true;
    direnv = {
      silent = true;
      enable = true;
      nix-direnv.enable = true;
    };
  };

  networking = { inherit (config.genesis) hostName; };

  nixpkgs.config.allowUnfree = true;
  nix = {
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = lib.singleton config.nix.settings.nix-path;

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      nix-path = "nixpkgs=flake:nixpkgs";
      builders-use-substitutes = true;
      http-connections = 0;
      max-substitution-jobs = 128;
      substituters = [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 4d";
    };
  };
}
