{
  homebrew = {
    onActivation = {
      cleanup = "zap";
      upgrade = true;
      autoUpdate = true;
    };
    # brews = [ "choose-gui" ];
    enable = true;
    casks = [
      "zed"
      "mac-mouse-fix"
      "wacom-tablet"
      "mullvadvpn"
      "obs"
      "krita"
      "affinity-designer"
      "affinity-photo"
      "affinity-publisher"
      "figma"
    ];
  };
}
