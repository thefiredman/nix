{
  # yabai only for instant window snapping
  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    config = {
      layout = "float";
      window_shadow = "off";
    };
  };
}
