{ lib, config, inputs, ... }: {
  options = {
    genesis = {
      hostName = lib.mkOption {
        type = with lib.types; str;
        description = "This is your host name. Must be defined explicitly.";
      };

      architecture = lib.mkOption {
        type = with lib.types; str;
        description = "Your systems architecture. Must be defined explicitly.";
      };
    };
  };

  config = {
    # NOTE: wrong place
    programs = {
      fish.enable = true;
      direnv = {
        silent = true;
        enable = true;
        nix-direnv.enable = true;
      };
    };

    networking = { hostName = config.genesis.hostName; };

    environment.shellAliases = { update = "nix flake update ~/nix"; };

    nix = {
      registry.nixpkgs.flake = inputs.nixpkgs;
      nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

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

    nixpkgs.config.allowUnfree = true;
  };
}
