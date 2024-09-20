{ inputs, linuxGenesis, homeLinux, ... }: {
  flake.nixosConfigurations.notflix = linuxGenesis "x86_64-linux" "notflix" [
    ./disko
    ./hardware.nix
    ./configuration.nix
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.impermanence.nixosModules.impermanence
    inputs.self.nixosModules.chromium
    (homeLinux "dashalev" [ ./home/dashalev.nix ])
  ];
}
