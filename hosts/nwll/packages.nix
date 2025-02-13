{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      onlyoffice-desktopeditors
      zathura
      obs-studio
      aseprite
      ghostty
      prismlauncher
      airshipper
      brave
      firefox
      signal-desktop
      vesktop
      torzu
      cool-retro-term
      mullvad-vpn
      qbittorrent
    ];
  };
}
