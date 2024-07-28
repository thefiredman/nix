{ config, lib, pkgs, ... }: {
  options.h.river = {
    enable = lib.mkEnableOption "Enables River WM." // { default = false; };
  };

  config = lib.mkIf config.h.river.enable {
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
            "spawn 'pkill tofi || riverctl spawn \"$(${pkgs.tofi}/bin/tofi-drun)\"'";
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
          # "'${pkgs.wlr-randr}/bin/wlr-randr --output Virtual-1 --mode 4096x2160'"
          "'${pkgs.sandbar}/bin/sandbar \\
             -font \"monospace:size=32\" \\
             -active-fg-color \"#000000\" \\
             -active-bg-color \"#98971a\" \\
             -inactive-fg-color \"#ebdbb2\" \\
             -inactive-bg-color \"#000000\" \\
             -urgent-fg-color \"#000000\" \\
             -urgent-bg-color \"#cc241d\" \\
             -title-fg-color \"#000000\" \\
             -title-bg-color \"#98971a\" \\
             -bottom
         '"
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
