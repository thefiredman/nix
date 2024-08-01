{ pkgs, ... }: {
  config = {
    h = {
      shell = {
        package = pkgs.fish;
        colour = "blue";
        icon = "😈";
      };

      river.enable = true;
      foot.enable = true;
      fuzzel.enable = true;
      kitty.enable = true;
    };
  };
}
