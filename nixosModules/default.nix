{
  flake.nixosModules = {
    genesis = import ./genesis;
    nixos = import ./nixos.nix;
    darwin = import ./darwin.nix;
    chromium = import ./chromium.nix;
  };
}
