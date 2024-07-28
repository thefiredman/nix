{pkgs, ...}:{
  config.h = {
    shell = {
      package = pkgs.fish;
      colour = "blue";
      icon = "🍅";
    };

    kitty.enable = true;
    river.enable = true;
    foot.enable = true;
  };
}
