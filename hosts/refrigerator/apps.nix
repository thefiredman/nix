_: {
  homebrew = {
    onActivation = {
      cleanup = "zap";
      upgrade = true;
      autoUpdate = true;
    };
    brews = [ "choose-gui" ];
    enable = true;
    casks = [
      "tidal"
      "mullvadvpn"
      "prismlauncher"
      "krita"
      "tiled"
      "tg-pro"
      "parsec"
      "firefox"
      "godot"
      "figma"
      "obs"
      "zed"
      "affinity-designer"
      "affinity-photo"
      "affinity-publisher"
      "blender"
      "qbittorrent"
      "discord"
      "wacom-tablet"
    ];
  };
}
