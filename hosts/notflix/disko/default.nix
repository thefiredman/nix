{ inputs, }: {
  imports = [
    ./a.nix
    ./b.nix
    inputs.self.nixosModules.zfs
  ];
}
