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
    };

    home = {
      pointerCursor = {
        gtk.enable = true;
        package = pkgs.whitesur-cursors;
        name = "WhiteSur-cursors";
        size = 32;
        x11.enable = true;
      };

      packages = with pkgs; [ ];
    };
  };
}
