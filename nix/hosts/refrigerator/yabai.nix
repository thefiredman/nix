{
  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
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
    extraConfig = ''
      yabai -m rule --add app=".*" manage=off

      # only manage these apps
      yabai -m rule --add app="kitty" manage=on
      yabai -m rule --add app="Safari" manage=on
    '';
  };
}
