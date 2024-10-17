{ inputs, linuxGenesis, homeLinux, ... }: {
  flake.nixosConfigurations.notflix = linuxGenesis "x86_64-linux" "notflix" [
    inputs.chaotic.nixosModules.default
    ./disko
    ./hardware.nix
    ./configuration.nix
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.self.nixosModules.chromium
    (homeLinux "dashalev" [ ./home/dashalev.nix ])
  ];
}
