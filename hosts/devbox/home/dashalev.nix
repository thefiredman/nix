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

    home = {
      pointerCursor = {
        gtk.enable = false;
        package = pkgs.whitesur-cursors;
        name = "WhiteSur-cursors";
        size = 32;
      };

      packages = with pkgs; [ ];
    };
  };
}
