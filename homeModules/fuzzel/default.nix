{ config, lib, pkgs, ... }: {
  options.h.fuzzel = {
    enable = lib.mkEnableOption "Enables fuzzel menu." // { default = false; };
  };

  config = lib.mkIf config.h.fuzzel.enable {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          terminal = "${pkgs.foot}/bin/footclient";
          layer = "overlay";
          font = "monospace:size=28";
        };

        colors = {
          background = "101010ff";
          text = "ffffffff";
          selection = "00000000";
          selection-text = "b16286ff";
        };

        border = {
          width = "0";
        };
      };
    };
  };
}
