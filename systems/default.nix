_: {
  flake.nixosModules = {
    darwin = import ./darwin.nix;
    nixsys = import ./nixsys.nix;
    options = import ./options.nix;
  };
}
