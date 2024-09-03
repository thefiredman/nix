{ config, lib, ... }: {
  options.h.wezterm = {
    enable = lib.mkEnableOption "Enables wezterm terminal." // {
      default = false;
    };
  };

  config = lib.mkIf config.h.wezterm.enable {
    programs.wezterm = {
      enable = true;
      extraConfig = ''
        return {
          font = wezterm.font "CaskaydiaCove Nerd Font Mono",
          font_size = 16.0,
          enable_tab_bar = false,
        }
      '';
    };
  };
}
