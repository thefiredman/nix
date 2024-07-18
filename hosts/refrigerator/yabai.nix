{
  services.yabai = {
    enable = true;
    config = {
      layout = "bsp";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      top_padding = 16;
      bottom_padding = 16;
      left_padding = 16;
      right_padding = 16;
      window_gap = 8;
    };
    enableScriptingAddition = true;
    extraConfig = builtins.readFile ./yabai.sh;
  };
}
