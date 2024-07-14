{ pkgs, config, ... }: {
  home-manager.users.${config.userName} = {
    imports = [ ./scripts.nix ];
    config.h = {
      shell = {
        package = pkgs.fish;
        colour = "magenta";
        icon = "🍺";
      };
    };
  };
}
