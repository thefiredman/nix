{ darwinGenesis, homeGenesis, ... }: {
  flake.darwinConfigurations.refrigerator =
    darwinGenesis "aarch64-darwin" "refrigerator" [
      ./configuration.nix
      ./scripts.nix
      ./homebrew.nix
      ./yabai.nix
      ./skhd.nix
      (homeGenesis "shalev" "Users" [ ./home ])
    ];
}
