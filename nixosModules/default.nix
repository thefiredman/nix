{
  flake.nixosModules = {
    nixsys = import ./nixsys.nix;
    darwin = import ./darwin;
  };
}
