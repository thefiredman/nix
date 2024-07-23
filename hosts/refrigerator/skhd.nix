{ pkgs, ... }: {
  services.skhd = {
    enable = true;
    skhdConfig = ''
      ctrl - return    : ${pkgs.kitty}/bin/kitty --single-instance -d ~
      alt - m         : music-player r
      alt + shift - n : music-player n
      alt + shift - p : music-player p
      alt + shift - b : mk-bookmark
    '';
  };
}
