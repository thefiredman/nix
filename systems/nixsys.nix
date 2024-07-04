{ lib, config, inputs, ... }: {
  options = { sys.nix.enable = lib.mkEnableOption "Nix Essentials"; };

  config = lib.mkIf config.sys.nix.enable {
    networking = { hostName = config.sys.host; };

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
        options = "--delete-older-than 2d";
      };
    };

    nixpkgs.config.allowUnfree = true;
  };
}
