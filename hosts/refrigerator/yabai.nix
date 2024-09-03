{
  # yabai only for instant window snapping
  services.yabai = {
    enable = false;
    enableScriptingAddition = true;
    config = {
      layout = "float";
      window_shadow = "off";
    };
  };
}
