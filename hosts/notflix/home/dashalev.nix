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
      sandbar.enable = false;

      extraConfig = ''
        riverctl spawn "${pkgs.wlr-randr}/bin/wlr-randr --output DP-2 --scale 2.0 --mode 3840x2160@119.999001"
      '';
    };

    hyprland = {
      enable = true;
      extraConfig = ''
        monitor = DP-2, 3840x2160@165, 0x0, 1
      '';
    };

    fuzzel.enable = true;
    xdg.enable = true;
  };
}
