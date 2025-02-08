{ pkgs, ... }: {
  programs = { mpv = { enable = true; }; };

  xdg = {
    mimeApps = let browser = "brave-browser";
    in {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/http" = "${browser}.desktop";
        "x-scheme-handler/https" = "${browser}.desktop";
      };
    };
  };

  services = {
    dunst = {
      enable = true;
      settings = {
        global = {
          width = 300;
          height = 300;
          offset = "30x50";
          origin = "top-right";
          transparency = 10;
          frame_color = "#eceff1";
        };
        urgency_normal = {
          background = "#37474f";
          foreground = "#eceff1";
          timeout = 10;
        };
      };
    };

    kanshi = {
      enable = true;
      settings = [
        {
          profile.outputs = [{
            criteria = "HDMI-A-1";
            status = "enable";
            mode = "3840x2160@120Hz";
          }];
        }
        {
          profile.outputs = [{
            criteria = "DP-4";
            status = "enable";
            mode = "3840x2160@165Hz";
          }];
        }
        {
          profile.outputs = [{
            criteria = "DP-2";
            status = "enable";
            mode = "3840x2160@165Hz";
          }];
        }
        {
          profile.outputs = [{
            criteria = "DP-3";
            status = "enable";
            mode = "3840x2160@165Hz";
          }];
        }
        {
          profile.outputs = [{
            criteria = "DP-1";
            status = "enable";
            mode = "3840x2160@165Hz";
          }];
        }
        {
          profile.outputs = [{
            criteria = "DP-0";
            status = "enable";
            mode = "3840x2160@165Hz";
          }];
        }
      ];
    };
  };

  h = {
    shell = {
      package = pkgs.fish;
      colour = "green";
      icon = "🗿";
    };

    foot.enable = true;
    wayland.enable = true;

    river = {
      enable = true;
      extraConfig = ''
        pkill kanshi
        riverctl spawn "${pkgs.kanshi}/bin/kanshi &"
        pkill dunst
        riverctl spawn "${pkgs.dunst}"
      '';
      # pkill wlclock
      # riverctl spawn "${pkgs.wlclock}/bin/wlclock --clock-colour '#ffffff' --background-colour '#00000000' --border-size 0 --exclusive-zone false --layer bottom --position top-right --size 230 --margin 20 --hand-width 2 --marking-width 2"
      # pkill mpvpaper
      # riverctl spawn "${pkgs.mpvpaper}/bin/mpvpaper -o 'no-audio --loop-playlist shuffle' '*' ${
      #   ../../../home/wallpapers/Sasuke.Uchiha.Sharingan/video.mp4
      # }"
    };

    fuzzel.enable = true;
    xdg.enable = true;
  };
}
