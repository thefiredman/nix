{ pkgs, ... }: {
  config.h = {
    shell = {
      package = pkgs.fish;
      colour = "blue";
      icon = "😈";
    };

    river.enable = true;
    foot.enable = true;
    tofi.enable = true;
  };
}
