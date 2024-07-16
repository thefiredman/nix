{ pkgs, ... }: {
  config.h = {
    shell = {
      package = pkgs.fish;
      colour = "magenta";
      icon = "🍺";
    };
  };
}
