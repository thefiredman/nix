{ pkgs, ... }: {
  services.skhd = {
    enable = true;
    skhdConfig = ''
      ctrl + shift - return : ${pkgs.kitty}/bin/kitty --single-instance -d ~
      alt - m               : music-player r
      alt + shift - n       : music-player n
      alt + shift - p       : music-player p
      alt + shift - s       : mk-bookmark
      alt + shift - b       : open -a Safari
      ctrl + shift - q      : yabai -m window --close
      ctrl + shift - s      : yabai -m window --toggle float

      ctrl + shift - h      : yabai -m window --focus west
      ctrl + shift - j      : yabai -m window --focus south
      ctrl + shift - k      : yabai -m window --focus north
      ctrl + shift - l      : yabai -m window --focus east

      ctrl + shift - f      : yabai -m window --toggle native-fullscreen
      ctrl + shift - 1      : yabai -m space --focus 1
      ctrl + shift - 2      : yabai -m space --focus 2
      ctrl + shift - 3      : yabai -m space --focus 3
      ctrl + shift - 4      : yabai -m space --focus 4
      ctrl + shift - 5      : yabai -m space --focus 5
      ctrl + shift - 6      : yabai -m space --focus 6
      ctrl + shift - 7      : yabai -m space --focus 7
      ctrl + shift - 8      : yabai -m space --focus 8
      ctrl + shift - 9      : yabai -m space --focus 9
      ctrl + shift - 0      : yabai -m space --focus 10
    '';
  };
}
