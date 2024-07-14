{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "music-player";

      text = ''
        case "$1" in
          r)
            osascript -e 'tell app "Music" to playpause'
            ;;
          n)
            osascript -e 'tell app "Music" to play next track'
            ;;
          p)
            osascript -e 'tell app "Music" to back track'
            ;;
          *)
            ;;
        esac
      '';
    })

    (writeShellScriptBin "list-bookmarks" ''
      touch ${config.h.dataHome}/bookmarks
      cat ${config.h.dataHome}/bookmarks | /opt/homebrew/bin/choose | pbcopy || exit 1
      osascript -e 'tell application "System Events" to keystroke "v" using command down'
      sleep 0.1
      osascript -e 'tell application "System Events" to key code 36'
    '')

    (writeShellScriptBin "mk-bookmark" ''
      touch ${config.h.dataHome}/bookmarks
      pbpaste >> ${config.h.dataHome}/bookmarks
      osascript -e 'display notification "'$(pbpaste)'" with title "Created Bookmark 📑"'
    '')
  ];
}
