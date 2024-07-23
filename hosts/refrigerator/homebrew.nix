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
      "utm"
      "mullvadvpn"
      "prismlauncher"
      "krita"
      "tiled"
      "tg-pro"
      "parsec"
      "firefox"
      "figma"
      "obs"
      "zed"
      "affinity-designer"
      "affinity-photo"
      "affinity-publisher"
      "blender"
      "qbittorrent"
      "wacom-tablet"
      # for now
      "rectangle"
    ];
  };
}
