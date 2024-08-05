{ config, pkgs, inputs, ... }:
let domain = "thefiredman.xyz";
in {
  imports = [
    (import ./jellyfin.nix { inherit config domain pkgs; })
    (import ./vaultwarden.nix { inherit config domain pkgs; })
    (import ./gitea.nix { inherit config domain pkgs; })
    (import ./caddy.nix { inherit config domain pkgs; })
    (import ./www.nix { inherit config domain pkgs; })
    # (import ./photoprism.nix { inherit config domain pkgs; })
    (import ./immich.nix { inherit config domain pkgs inputs; })
  ];
}
