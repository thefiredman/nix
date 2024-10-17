{ config, lib, ... }: {
  options.h.hyprland = {
    enable = lib.mkEnableOption "Enables Hyperland WM." // { default = false; };

    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
    };
  };

  config = lib.mkIf config.h.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = ''
        $mod = ALT

        bind = $mod, RETURN, exec, foot
        bind = $mod, Q, killactive
        bind = $mod, F, fullscreen

        bind = $mod, 1, workspace, 1
        bind = $mod, 2, workspace, 2
        bind = $mod, 3, workspace, 3
        bind = $mod, 4, workspace, 4
        bind = $mod, 5, workspace, 5
        bind = $mod, 6, workspace, 6
        bind = $mod, 7, workspace, 7
        bind = $mod, 8, workspace, 8
        bind = $mod, 9, workspace, 9
        bind = $mod, 0, workspace, 10

        ${config.h.hyprland.extraConfig}
      '';
    };
  };
}
