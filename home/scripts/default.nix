{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    (writeShellApplication {
      name = "yonk";

      runtimeInputs = [ git ];

      text = ''
        git clone --recurse-submodules "git@github.com:$1.git"
      '';
    })
    (writeShellApplication {
      name = "yt-mp3";
      runtimeInputs = [ yt-dlp ];

      text = ''
        yt-dlp --audio-quality 0 --extract-audio --audio-format mp3 "$1"
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
