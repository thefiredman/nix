{ inputs, linuxGenesis, homeLinux, ... }: {
  flake.nixosConfigurations.nwll = linuxGenesis "x86_64-linux" "nwll" [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    inputs.self.nixosModules.chromium
    inputs.chaotic.nixosModules.default
    ./disko
    ./hardware.nix
    ./configuration.nix
    (homeLinux "dashalev" [ ./home/dashalev.nix ])
  ];
}
