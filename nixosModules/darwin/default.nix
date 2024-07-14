{ lib, pkgs, config, ... }: {
  options.modules = { darwin.enable = lib.mkEnableOption "Enable MacOS"; };

  config = lib.mkIf config.modules.darwin.enable {
    environment = {
      systemPackages = with pkgs; [ dash ];
      shells = [ pkgs.dash ];
    };

    homeRoot = lib.mkForce "Users";

    services.nix-daemon.enable = true;
    security.pam.enableSudoTouchIdAuth = true;

    environment.shellAliases = {
      upgrade = "darwin-rebuild switch --flake ~/nix#${config.host}";
      bootgrade = "darwin-rebuild build --flake ~/nix#${config.host}";
    };

    system = { stateVersion = lib.mkForce 4; };
  };
}
