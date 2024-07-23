{ linuxGenesis, homeGenesis, ... }: {
  flake.nixosConfigurations.devbox =
    linuxGenesis "aarch64-linux" "devbox" [
      ./configuration.nix
      (homeGenesis "dashalev" "home" [ ./home ])
    ];
}
