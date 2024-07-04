{ pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
      (writeShellApplication {
        name = "music-play";

        text = ''
          osascript -e 'tell application "System Events"
              tell process "TIDAL"
                  click menu item 0 of menu "Playback" of menu bar 1
              end tell
          end tell'
        '';
      })
    ];
}
