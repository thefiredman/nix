{
  description = "Shalev's blood.";

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-darwin" "aarch64-linux" "x86_64-linux" ];
      imports = [ ./hosts ./nixosModules ./home ./packages ];
      perSystem = { };
    };

  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    apple-emoji-linux = {
      url =
        "https://github.com/samuelngs/apple-emoji-linux/releases/download/v17.4/AppleColorEmoji.ttf";
      flake = false;
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };

    chaotic = {
      type = "github";
      owner = "chaotic-cx";
      repo = "nyx";
      ref = "nyxpkgs-unstable";
    };

    flake-parts = {
      type = "github";
      owner = "hercules-ci";
      repo = "flake-parts";
      inputs = { nixpkgs-lib.follows = "nixpkgs"; };
    };

    disko = {
      type = "github";
      owner = "nix-community";
      repo = "disko";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };

    nix-darwin = {
      type = "github";
      owner = "LnL7";
      repo = "nix-darwin";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };

    impermanence = {
      type = "github";
      owner = "nix-community";
      repo = "impermanence";
    };

    nixos-hardware = {
      type = "github";
      owner = "NixOS";
      repo = "nixos-hardware";
    };

    nixCats = {
      type = "github";
      owner = "BirdeeHub";
      repo = "nixCats-nvim";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    affinity-nix.url = "github:mrshmllow/affinity-nix";
  };
}
