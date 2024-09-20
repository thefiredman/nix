{ pkgs, ... }: {
  services.skhd = {
    enable = true;
    skhdConfig = ''
      cmd - return          : ${pkgs.kitty}/bin/kitty --single-instance -d ~
      alt - m               : music-player r
      alt + shift - n       : music-player n
      alt + shift - p       : music-player p
    '';

    # these are reserved for full screen applications
    # the other shortcuts to switch workspaces are defined in macos
    # because its more responsive
    # alt - 9               : yabai -m space --focus 9
    # alt - 0               : yabai -m space --focus 10
    # alt + shift - 1       : yabai -m space --focus 1
    # alt + shift - 2       : yabai -m space --focus 2
    # alt + shift - 3       : yabai -m space --focus 3
    # alt + shift - 4       : yabai -m space --focus 4
    # alt + shift - 5       : yabai -m space --focus 5
    # alt + shift - 6       : yabai -m space --focus 6
    # alt + shift - 7       : yabai -m space --focus 7
    # alt + shift - 8       : yabai -m space --focus 8
    # alt + shift - 9       : yabai -m space --focus 9
    # alt + shift - 0       : yabai -m space --focus 10
  };
}
