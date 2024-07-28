{ config, lib, pkgs, ... }: {
  options.h.foot = {
    enable = lib.mkEnableOption "Enables Foot terminal." // {
      default = false;
    };
  };

  config = lib.mkIf config.h.foot.enable {
    programs.foot =  {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          font = "monospace:size=12";
          term = "xterm-256color";
          dpi-aware = "yes";
          pad = "6x6";
        };

        mouse = {
          hide-when-typing = "yes";
        };

        colors = {
        };
      };
    };
  };
}
