{
  homebrew = {
    onActivation = {
      cleanup = "zap";
      upgrade = true;
      autoUpdate = true;
    };
    enable = true;
    casks = [
      "affinity-designer"
      "affinity-photo"
      "figma"
      "eloston-chromium"
      "firefox"
      "qbittorrent"
      "mullvadvpn"
    ];
  };
}
