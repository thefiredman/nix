{ withSystem, darwinGenesis, homeGenesis, ... }:
let system = "aarch64-darwin";
in {
  flake.darwinConfigurations.refrigerator = withSystem system (_:
    darwinGenesis system "refrigerator"  [
      ./configuration.nix
      ./scripts.nix
      ./apps.nix
      ./yabai.nix
      ./skhd.nix
      (homeGenesis "shalev" "Users" [ ./users/shalev ])
    ]);
}
