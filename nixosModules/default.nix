{
  flake.nixosModules = {
    zfs = import ./zfs.nix;
    genesis = import ./genesis;
    systemGenesis = import ./genesis/system.nix;
    nixos = import ./nixos.nix;
    darwin = import ./darwin.nix;
  };
}
