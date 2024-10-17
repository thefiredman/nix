{ config, lib, pkgs, ... }: {
  options.h.river = {
    enable = lib.mkEnableOption "Enables River WM." // { default = false; };
    wallpaper = {
      enable = lib.mkEnableOption "Enables wallpaper rendering" // {
        default = false;
      };
      path = lib.mkOption {
        type = lib.types.nonEmptyStr;
        default = "${../wallpapers/donald_duck.jpg}";
      };
    };

    sandbar = {
      enable = lib.mkEnableOption "Enable Sandbar." // { default = true; };
      launch = lib.mkEnableOption "Automagically start it up." // {
        default = true;
      };
      extraConfig = lib.mkOption {
        type = lib.types.str;
        default = ''
          -font "monospace:size=24" -active-fg-color "#ffffff" -active-bg-color "#b16286" -title-bg-color "#000000" -inactive-bg-color "#000000"'';
      };
    };

    iconTheme = {
      name = lib.mkOption {
        type = lib.types.nonEmptyStr;
        default = "Adwaita";
      };
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.adwaita-icon-theme;
      };
    };

    cursorTheme = {
      name = lib.mkOption {
        type = with lib.types; nonEmptyStr;
        default = "Adwaita";
      };
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.adwaita-icon-theme;
      };
      size = lib.mkOption {
        type = with lib.types; number;
        default = 18;
      };
    };

    theme = {
      name = lib.mkOption {
        type = with lib.types; nonEmptyStr;
        default = "adw-gtk3-dark";
      };

      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.adw-gtk3;
      };
    };

    qt = {
      name = lib.mkOption {
        type = with lib.types; nonEmptyStr;
        default = "Adwaita-dark";
      };

      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.adwaita-qt;
      };
    };

    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
    };

    displayConfig = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
  };

  config = lib.mkIf config.h.river.enable {
    home = {
      sessionVariables = {
        NIXOS_OZONE_WL = "1";
        MOZ_ENABLE_WAYLAND = "1";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        QT_QPA_PLATFORM = "wayland";
        XCURSOR_THEME = config.h.river.cursorTheme.name;
        XCURSOR_SIZE = "${toString config.h.river.cursorTheme.size}";
        GTK_THEME = config.h.river.theme.name;
      };

      packages = with pkgs; [
        wl-clipboard
        pavucontrol
        nautilus
        pulsemixer
        dconf-editor
        xorg.xeyes
        imv
      ];

      pointerCursor = {
        gtk.enable = true;
        inherit (config.h.river.cursorTheme) name;
        inherit (config.h.river.cursorTheme) package;
      };
    };

    gtk = {
      enable = true;
      theme = {
        inherit (config.h.river.theme) name;
        inherit (config.h.river.theme) package;
      };

      iconTheme = {
        inherit (config.h.river.iconTheme) name;
        inherit (config.h.river.iconTheme) package;
      };

      cursorTheme = {
        inherit (config.h.river.cursorTheme) name;
        inherit (config.h.river.cursorTheme) package;
        inherit (config.h.river.cursorTheme) size;
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style = {
        inherit (config.h.river.qt) package;
        inherit (config.h.river.qt) name;
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        cursor-theme = config.h.river.cursorTheme.name;
      };
      "org/gnome/desktop/wm/preferences" = { button-layout = ""; };
    };

    wayland.windowManager.river = let
      mod = "Alt";
      inherit (config.h.river) displayConfig;
    in {
      enable = true;
      package = pkgs.river_git;
      settings = {
        map.normal = {
          "${mod} Return" = "spawn '${pkgs.foot}/bin/footclient'";
          "${mod} Q" = "close";
          "${mod}+Shift R" =
            "spawn '${pkgs.wlr-randr}/bin/wlr-randr ${displayConfig}'";
          "${mod} F" = "toggle-fullscreen";
          "${mod} S" = "toggle-float";
          "${mod} J" = "focus-view next";
          "${mod} K" = "focus-view previous";
          "${mod}+Shift S" =
            "spawn 'pkill grimshot || ${pkgs.sway-contrib.grimshot}/bin/grimshot --notify copy area | -'";
          "${mod} Space" = "spawn 'pkill fuzzel || ${pkgs.fuzzel}/bin/fuzzel'";
          "${mod}+Shift H" = "swap next";
          "${mod}+Shift J" = "swap previous";
          "${mod}+Shift Q" = "exit";
        } // lib.optionals config.h.river.sandbar.enable {
          "${mod} U" =
            "spawn 'pkill sandbar || ${pkgs.sandbar}/bin/sandbar ${config.h.river.sandbar.extraConfig}'";
        };

        map-pointer.normal = {
          "${mod} BTN_LEFT" = "move-view";
          "${mod} BTN_RIGHT" = "resize-view";
        };

        default-layout = "rivertile";
        background-color = "0x000000";
        border-width = 0;
        set-repeat = "50 300";

        spawn = [
          "'${pkgs.foot}/bin/foot --server --log-no-syslog'"
          "'${pkgs.river}/bin/rivertile -view-padding 0 -outer-padding 0 -main-ratio 0.5 -main-location left'"
        ] ++ lib.optionals config.h.river.sandbar.launch [''
          "${pkgs.sandbar}/bin/sandbar ${config.h.river.sandbar.extraConfig}"
        ''] ++ lib.optionals config.h.river.wallpaper.enable
          [ "'${pkgs.wbg}/bin/wbg ${config.h.river.wallpaper.path}'" ];
      };

      extraConfig = ''
        for i in $(seq 1 9)
        do
            tags=$((1 << (i - 1)))
            riverctl map normal ${mod} "$i" set-focused-tags $tags
            riverctl map normal ${mod}+Shift "$i" set-view-tags $tags
            riverctl map normal ${mod}+Control "$i" toggle-focused-tags $tags
            riverctl map normal ${mod}+Shift+Control "$i" toggle-view-tags $tags
        done

        for mouse in $(riverctl list-inputs | grep -i pointer)
        do
          riverctl input $mouse accel-profile flat
        done

        riverctl spawn '${pkgs.wlr-randr}/bin/wlr-randr ${displayConfig}'

        all_tags=$(((1 << 32) - 1))
        riverctl map normal ${mod} 0 set-focused-tags "$all_tags"
        riverctl map normal ${mod}+Shift 0 set-view-tags "$all_tags"

        ${config.h.river.extraConfig}
      '';
    };
  };
}
