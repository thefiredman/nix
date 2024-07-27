{
  flake.nixosModules = {
    genesis = import ./genesis.nix;
    nixos = import ./nixos.nix;
    darwin = import ./darwin.nix;
    vm = import ./vm.nix;
  };
}
