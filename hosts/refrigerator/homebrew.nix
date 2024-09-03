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
      "prismlauncher"
      "mac-mouse-fix"
      "wacom-tablet"
      "firefox"
      "obs"
      "krita"
      "affinity-designer"
      "affinity-photo"
      "affinity-publisher"
      "figma"
    ];
  };
}
