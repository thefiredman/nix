{ pkgs, ... }: {
  services.skhd = {
    enable = true;
    skhdConfig = ''
      cmd - return          : ${pkgs.kitty}/bin/kitty --single-instance -d ~
      alt - m               : music-player r
      alt + shift - n       : music-player n
      alt + shift - p       : music-player p
    '';
  };
}
