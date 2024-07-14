{ lib, config, ... }: {
  options.modules = { nixos.enable = lib.mkEnableOption "Enable NixOS"; };

  config = lib.mkIf config.modules.nixos.enable {
    homeRoot = lib.mkForce "home";

    system = { stateVersion = lib.mkForce 4; };
  };
}
