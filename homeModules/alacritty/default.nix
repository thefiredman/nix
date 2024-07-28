{ config, lib, ... }: {
  options.h.alacritty = {
    enable = lib.mkEnableOption "Enables alacritty terminal." // {
      default = true;
    };
  };

  config = lib.mkIf config.h.alacritty.enable {
    programs.alacritty = { enable = true; };
  };
}
