{ darwinGenesis, homeDarwin, ... }: {
  flake.darwinConfigurations.refrigerator =
    darwinGenesis "aarch64-darwin" "refrigerator" [
      ./configuration.nix
      ./scripts.nix
      ./homebrew.nix
      # ./yabai.nix
      ./skhd.nix
      (homeDarwin "aarch64-darwin" "dashalev" [ ./Users/dashalev.nix ])
    ];
}
