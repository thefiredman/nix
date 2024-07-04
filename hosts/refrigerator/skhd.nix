{ pkgs, config, ... }: {
  services.skhd = {
    enable = true;
    skhdConfig = ''
      alt - h : yabai -m window --focus west
      alt - j : yabai -m window --focus south
      alt - k : yabai -m window --focus north
      alt - l : yabai -m window --focus east

      # switch between workspaces
      alt - 1 : yabai -m space --focus 1
      alt - 2 : yabai -m space --focus 2
      alt - 3 : yabai -m space --focus 3
      alt - 4 : yabai -m space --focus 4
      alt - 5 : yabai -m space --focus 5
      alt - 6 : yabai -m space --focus 6
      alt - 7 : yabai -m space --focus 7
      alt - 8 : yabai -m space --focus 8
      alt - 9 : yabai -m space --focus 9
      alt - 0 : yabai -m space --focus 10

      # move apps between workspaces
      alt + shift - 1 : yabai -m window --space 1
      alt + shift - 2 : yabai -m window --space 2
      alt + shift - 3 : yabai -m window --space 3
      alt + shift - 4 : yabai -m window --space 4
      alt + shift - 5 : yabai -m window --space 5
      alt + shift - 6 : yabai -m window --space 6
      alt + shift - 7 : yabai -m window --space 7
      alt + shift - 8 : yabai -m window --space 8
      alt + shift - 9 : yabai -m window --space 9
      alt + shift - 0 : yabai -m window --space 10

      # swap windows
      alt - left      : yabai -m window --swap west
      alt - right     : yabai -m window --swap east
      alt - up        : yabai -m window --swap north
      alt - down      : yabai -m window --swap south

      # spawn
      alt - return    : ${pkgs.kitty}/bin/kitty --single-instance -d ${config.h.homePath}
      alt - m         : music-play
      alt - b         : list-bookmarks
      alt + shift - b : mk-bookmark

      # resize
      shift + alt - h : yabai -m window --resize left:-50:0; yabai -m window --resize right:-50:0
      shift + alt - j : yabai -m window --resize bottom:0:50; yabai -m window --resize top:0:50
      shift + alt - k : yabai -m window --resize top:0:-50; yabai -m window --resize bottom:0:-50
      shift + alt - l : yabai -m window --resize right:50:0; yabai -m window --resize left:50:0

      # other
      shift + alt - f : yabai -m window --toggle native-fullscreen
      cmd - q         : yabai -m window --close
      alt - s         : yabai -m window --toggle float
      alt - m         : music-play
    '';
  };
}
