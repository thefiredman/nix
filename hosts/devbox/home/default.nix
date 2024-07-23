{ pkgs, ... }: {
  config.h = {
    shell = {
      package = pkgs.fish;
      colour = "pink";
      icon = "🍅";
    };
  };
}
