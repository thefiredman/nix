{
  perSystem = { pkgs, system, ... }: {
    packages = {
      apple-emoji = pkgs.callPackage ./apple-emoji.nix { };
      cider2 = pkgs.callPackage ./cider2.nix { };
    };
  };
}
