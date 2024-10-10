{ pkgs, ... }: {
  config = {
    h = {
      shell = {
        package = pkgs.fish;
        colour = "blue";
        icon = "😈";
      };

      river = {
        enable = true;
        cursorTheme = {
          name = "WhiteSur-cursors";
          package = pkgs.whitesur-cursors;
        };
        extraConfig = ''
          riverctl spawn "${pkgs.wlr-randr}/bin/wlr-randr --output Virtual-1 --mode 3840x2160 --scale 2"
        '';
      };

      foot.enable = true;
      fuzzel.enable = true;
      kitty.enable = false;
    };
  };
}
