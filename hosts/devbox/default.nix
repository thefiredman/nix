{ linuxGenesis, homeLinux, ... }: {
  flake.nixosConfigurations.devbox = linuxGenesis "aarch64-linux" "devbox" [
    ./configuration.nix
    ./hardware.nix
    ./disko
    (homeLinux "dashalev" [ ./home/dashalev.nix ])
  ];
}
