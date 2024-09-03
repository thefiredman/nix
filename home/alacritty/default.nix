{ config, lib, ... }: {
  options.h.alacritty = {
    enable = lib.mkEnableOption "Enables alacritty terminal." // {
      default = false;
    };
  };

  config =
    lib.mkIf config.h.alacritty.enable { programs.alacritty = { enable = true; }; };
}
