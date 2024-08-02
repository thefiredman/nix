{ inputs, ... }: {
  imports = [ ../nixosModules/systemGenesis.nix ./devbox ./refrigerator ];
}
