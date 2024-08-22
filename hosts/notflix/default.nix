{ inputs, linuxGenesis, homeLinux, ... }: {
  flake.nixosConfigurations.notflix = linuxGenesis "x86_64-linux" "notflix" [
    ./disko
    ./hardware.nix
    ./configuration.nix
    ./services
    ./tunnel.nix
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.impermanence.nixosModules.impermanence
    (homeLinux "dashalev" [ ./home/dashalev.nix ])
  ];
}
