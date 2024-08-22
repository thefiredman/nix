{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
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

    # (writeShellScriptBin "mk-bookmark" ''
    #   ctx="$(pbpaste)"
    #
    #   if [[ $(cat "$XDG_DATA_HOME/bookmarks") = *$'\n' ]]; then
    #     new_line="";
    #   else
    #     new_line=$'\n';
    #   fi
    #
    #   touch "$XDG_DATA_HOME/bookmarks"
    #   (printf "%s" "$new_line$ctx") >> "$XDG_DATA_HOME/bookmarks"
    #   osascript -e "$(printf "display notification \"%s\" with title \"Created Bookmark 📑\"" "$ctx")"
    # '')
  ];
}
