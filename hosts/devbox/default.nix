{ inputs, linuxGenesis, homeLinux, ... }: {
  flake.nixosConfigurations.devbox = linuxGenesis "aarch64-linux" "devbox" [
    ./configuration.nix
    ./hardware.nix
    ./disko
    inputs.self.nixosModules.vm
    (homeLinux "dashalev" [ ./home/dashalev.nix ])
  ];
}
