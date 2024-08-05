{ config, lib, pkgs, ... }: {
  options.h.river = {
    enable = lib.mkEnableOption "Enables River WM." // { default = false; };
    wallpaper = lib.mkOption {
      type = with lib.types; nonEmptyStr;
      default = "${../wallpapers/donald_duck.jpg}";
    };

    iconTheme = {
      name = lib.mkOption {
        type = with lib.types; nonEmptyStr;
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
        default = "WhiteSur-cursors";
      };
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.whitesur-cursors;
      };
      size = lib.mkOption {
        type = with lib.types; number;
        default = 24;
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
  };

  config = lib.mkIf config.h.river.enable {
    home = {
      packages = with pkgs; [ wl-clipboard pavucontrol nautilus pulsemixer ];
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
      platformTheme = "gtk3";
      style.name = config.h.river.theme.name;
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        cursor-theme = config.h.river.cursorTheme.name;
      };
      "org/gnome/desktop/wm/preferences" = { button-layout = ""; };
    };

    wayland.windowManager.river = let mod = "Mod1";
    in {
      enable = true;
      settings = {
        map.normal = {
          "${mod} Return" = "spawn '${pkgs.foot}/bin/footclient'";
          "${mod} Q" = "close";
          "${mod} F" = "toggle-fullscreen";
          "${mod} S" = "toggle-float";
          "${mod} J" = "focus-view next";
          "${mod} K" = "focus-view previous";
          "${mod} Space" =
            "spawn 'pkill fuzzel || riverctl spawn \"$(${pkgs.fuzzel}/bin/fuzzel)\"'";
          "${mod}+Shift H" = "swap next";
          "${mod}+Shift J" = "swap previous";
          "${mod}+Shift Q" = "exit";
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
          "'${pkgs.wbg}/bin/wbg ${config.h.river.wallpaper}'"
          ''
            "${pkgs.sandbar}/bin/sandbar -font \"monospace:size=32\" -active-fg-color \"#ffffff\" -active-bg-color \"#b16286\" -title-bg-color \"#000000\" -inactive-bg-color \"#000000\""''
        ];
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

        all_tags=$(((1 << 32) - 1))
        riverctl map normal ${mod} 0 set-focused-tags "$all_tags"
        riverctl map normal ${mod}+Shift 0 set-view-tags "$all_tags"
      '';
    };
  };
}
