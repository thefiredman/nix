{ pkgs, ... }: {
  programs = {
    rtorrent.enable = true;
    firefox = { enable = true; };
    mpv = {
      enable = true;
      config = { hwdec = "cuda"; };
    };
  };

  h = {
    shell = {
      package = pkgs.fish;
      colour = "green";
      icon = "🗿";
    };

    foot.enable = true;

    river = {
      enable = true;
      sandbar = { launch = false; };

      wallpaper = { enable = false; };
      displayConfig = "--output DP-4 --mode 3840x2160@164.992004";
      extraConfig = ''
        riverctl spawn "${pkgs.wlclock}/bin/wlclock --clock-colour '#ffffff' --background-colour '#00000000' --border-size 0 --exclusive-zone false --layer bottom --position top-right --size 230 --margin 20 --hand-width 2 --marking-width 2"
        riverctl spawn "${pkgs.mpvpaper}/bin/mpvpaper -o 'no-audio --loop-playlist shuffle' DP-4 ${
          ../../../home/wallpapers/Sasuke.Uchiha.Sharingan/video.mp4
        }"
      '';
    };

    fuzzel.enable = true;
    xdg.enable = true;
  };
}
