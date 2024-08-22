{ pkgs, ... }: {
  config.h = {
    shell = {
      package = pkgs.fish;
      colour = "magenta";
      icon = "🍺";
    };

    kitty.enable = true;
    dev.enable = true;
    tmux.enable = true;
  };
}
