{
  homebrew = {
    onActivation = {
      cleanup = "zap";
      upgrade = true;
      autoUpdate = true;
    };
    brews = [ "choose-gui" ];
    enable = true;
    casks = [
      "mullvadvpn"
      "krita"
      "tiled"
      "tg-pro"
      "parsec"
      "firefox"
      "figma"
      "obs"
      "affinity-designer"
      "affinity-photo"
      "affinity-publisher"
      "blender"
      "qbittorrent"
      "wacom-tablet"
    ];
  };
}
