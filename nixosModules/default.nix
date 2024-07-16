{
  flake.nixosModules = {
    global = import ./global.nix;
    darwin = import ./darwin.nix;
  };
}
