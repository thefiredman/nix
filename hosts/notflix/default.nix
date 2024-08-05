{ inputs, linuxGenesis, homeLinux, ... }: {
  flake.nixosConfigurations.notflix = linuxGenesis "x86_64-linux" "notflix" [
    ./disko
    ./hardware.nix
    ./configuration.nix
    ./services
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.self.nixosModules.rollback
    inputs.impermanence.nixosModules.impermanence
    (homeLinux "dashalev" [ ./home/dashalev.nix ])
  ];
}
