{ config, lib, ... }: {

  options.h.kitty = {
    enable = lib.mkEnableOption "Enables kitty terminal." // { default = true; };
  };

  config = lib.mkIf config.h.kitty.enable {
    programs.kitty = {
      enable = true;
      font = {
        name = "CaskaydiaCove Nerd Font Mono";
        size = 30;
      };
      theme = "Gruvbox Dark Hard";
      darwinLaunchOptions = [ "--single-instance" ];
      shellIntegration = {
        enableFishIntegration = false;
        enableZshIntegration = false;
        enableBashIntegration = false;
      };
      keybindings = {
        "ctrl+equal" = "change_font_size all +2.0";
        "ctrl+minus" = "change_font_size all -2.0";
        "cmd+equal" = "change_font_size all +2.0";
        "cmd+minus" = "change_font_size all -2.0";
        "ctrl+shift+c" = "copy_to_clipboard";
        "cmd+p" = "copy_to_clipboard";
        "ctrl+shift+v" = "paste_from_clipboard";
        "cmd+v" = "paste_from_clipboard";
      };
      settings = {
        clear_all_shortcuts = "yes";
        window_padding_width = "3";
        shell =
          "${lib.getBin config.h.shell.package}/bin/${lib.getName config.h.shell.package}";
        background = "#000000";
        background_opacity = "0.87";
        background_blur = "20";
        macos_option_as_alt = "yes";
        cursor_shape = "block";
        copy_on_select = "yes";
        shell_integration = "disabled";
        cursor_blink_interval = 0;
        hide_window_decorations = "titlebar-only";
        confirm_os_window_close = 0;
        update_check_interval = 0;
        enable_audio_bell = "no";
        resize_debounce_time = "0";
      };
    };
  };
}
