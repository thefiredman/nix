{ pkgs, ... }:
{
  programs.rtorrent.enable = true;

  h = {
    shell = {
      package = pkgs.fish;
      colour = "green";
      icon = "🧸";
    };

    foot.enable = true;
    river = { enable = true; };
    fuzzel.enable = true;
    xdg.enable = true;
    chromium.enable = true;
  };
}
