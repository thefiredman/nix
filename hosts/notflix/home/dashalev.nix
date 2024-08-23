{ pkgs, ... }: {
  programs.rtorrent.enable = true;

  h = {
    shell = {
      package = pkgs.fish;
      colour = "green";
      icon = "🧸";
    };

    foot.enable = true;

    river = {
      enable = true;
      cursorTheme = {
        name = "WhiteSur-cursors";
        package = pkgs.whitesur-cursors;
      };

      extraConfig = ''
        riverctl spawn "${pkgs.wlr-randr}/bin/wlr-randr --output DP-3 --scale 2"
      '';
    };

    fuzzel.enable = true;
    xdg.enable = true;
    chromium.enable = true;
  };
}
