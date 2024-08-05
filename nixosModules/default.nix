{
  flake.nixosModules = {
    systemGenesis = import ./systemGenesis.nix;
    rollback = import ./rollback.nix;
    genesis = import ./genesis.nix;
    nixos = import ./nixos.nix;
    darwin = import ./darwin.nix;
    vm = import ./vm.nix;
  };
}
