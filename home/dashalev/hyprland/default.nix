{ config, lib, pkgs, ... }:
let
  mod = config.h.hyprland.mod;
  bookmarkPaste = pkgs.writeShellScriptBin "bookmark-paste" ''
    pkill wmenu; ${
      lib.getExe pkgs.wtype
    } "$(cat ${config.h.xdg.configHome}/bookmarks | 
      ${lib.getExe config.h.wmenu.pipe}
    )"
  '';

  bookmarkRemove = pkgs.writeShellScriptBin "bookmark-remove" ''
    line=$(tail -n1 ${config.h.xdg.configHome}/bookmarks)
    sed -i '$d' ${config.h.xdg.configHome}/bookmarks
    exec ${lib.getExe pkgs.libnotify} "📖 Bookmark Removed" -- "$line"
  '';

  bookmarkAdd = pkgs.writeShellScriptBin "bookmark-add" ''
    ${
      lib.getExe' pkgs.wl-clipboard "wl-paste"
    } >> ${config.h.xdg.configHome}/bookmarks
    exec ${lib.getExe pkgs.libnotify} "📖 Bookmark Added" "$(${
      lib.getExe' pkgs.wl-clipboard "wl-paste"
    })"
  '';

  toggleBitdepth = pkgs.writeShellScriptBin "toggle-hdr" ''
    hyprctl monitors -j | ${lib.getExe pkgs.jq} -c '.[]' | while read -r mon; do
      name=$(echo "$mon" | ${lib.getExe pkgs.jq} -r '.name')
      width=$(echo "$mon" | ${lib.getExe pkgs.jq} -r '.width')
      height=$(echo "$mon" | ${lib.getExe pkgs.jq} -r '.height')
      refresh=$(echo "$mon" | ${
        lib.getExe pkgs.jq
      } -r '.refreshRate' | cut -d'.' -f1)
      x=$(echo "$mon" | ${lib.getExe pkgs.jq} -r '.x')
      y=$(echo "$mon" | ${lib.getExe pkgs.jq} -r '.y')
      scale=$(echo "$mon" | ${lib.getExe pkgs.jq} -r '.scale' | cut -d'.' -f1)
      format=$(echo "$mon" | ${lib.getExe pkgs.jq} -r '.currentFormat')
      config="''${name},''${width}x''${height}@''${refresh},''${x}x''${y},''${scale}"

      case "''${format}" in
        *2101010*)
          hyprctl keyword monitor "''${config}"
          ${lib.getExe pkgs.libnotify} "HDR bitdepth 10" "Disabled on ''${name}"
          ;;
        *)
          hyprctl keyword monitor "''${config},bitdepth,10"
          ${lib.getExe pkgs.libnotify} "HDR bitdepth 10" "Enabled on ''${name}"
          ;;
      esac
    done
  '';
in {
  h = {
    xdg.configFiles = { "mako/config".source = ./mako; };
    hyprland.config = ''
      ${builtins.readFile ./hyprland.conf}

      bind=${mod}+Shift, Q, exit
      bind=${mod}+Shift, 0, pin
      bind=${mod}+Shift, H, resizeactive, -50 0
      bind=${mod}+Shift, L, resizeactive, 50 0
      bind=${mod}+Shift, J, layoutmsg, swapnext
      bind=${mod}+Shift, K, layoutmsg, swapprev
      bind=${mod}, Return, exec, ${lib.getExe' pkgs.foot "footclient"}
      bind=${mod}, Q, killactive
      bind=${mod}, F, fullscreen, 0
      bind=${mod}, S, togglefloating
      bind=${mod}, J, layoutmsg, cyclenext
      bind=${mod}, K, layoutmsg, cycleprev
      bind=${mod}+Shift, S, exec, pkill grimshot || ${
        lib.getExe pkgs.sway-contrib.grimshot
      } --notify copy area
      bind=${mod}+Shift, N, exec, pkill gammastep || ${
        lib.getExe pkgs.gammastep
      } -O 4000
      bind=${mod}+Shift, C, exec, pkill hyprpicker || ${
        lib.getExe pkgs.hyprpicker
      } | ${lib.getExe' pkgs.wl-clipboard "wl-copy"}
      bind=${mod}, Space, exec, pkill wmenu || ${lib.getExe config.h.wmenu.run}
      bind=${mod}, Z, exec, ${lib.getExe bookmarkPaste}
      bind=${mod}, X, exec, ${lib.getExe bookmarkAdd}
      bind=${mod}+Shift, X, exec, ${lib.getExe bookmarkRemove}

      bind=${mod}, code:10, workspace, 1
      bind=${mod} SHIFT, code:10, movetoworkspace, 1
      bind=${mod}, code:11, workspace, 2
      bind=${mod} SHIFT, code:11, movetoworkspace, 2
      bind=${mod}, code:12, workspace, 3
      bind=${mod} SHIFT, code:12, movetoworkspace, 3
      bind=${mod}, code:13, workspace, 4
      bind=${mod} SHIFT, code:13, movetoworkspace, 4
      bind=${mod}, code:14, workspace, 5
      bind=${mod} SHIFT, code:14, movetoworkspace, 5
      bind=${mod}, code:15, workspace, 6
      bind=${mod} SHIFT, code:15, movetoworkspace, 6
      bind=${mod}, code:16, workspace, 7
      bind=${mod} SHIFT, code:16, movetoworkspace, 7
      bind=${mod}, code:17, workspace, 8
      bind=${mod} SHIFT, code:17, movetoworkspace, 8
      bind=${mod}, code:18, workspace, 9
      bind=${mod} SHIFT, code:18, movetoworkspace, 9
      bindm=${mod}, mouse:272, movewindow
      bindm=${mod}, mouse:273, resizewindow
      bind=${mod}, F9, exec, ${lib.getExe toggleBitdepth}

      exec=${lib.getExe pkgs.mako}
      exec-once=${lib.getExe pkgs.foot} --server --log-no-syslog
    '';
  };
}
