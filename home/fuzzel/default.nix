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
          font = "monospace:size=24";
        };

        colors = {
          background = "000000ff";
          text = "ffffffff";
          selection = "00000000";
          selection-text = "b16286ff";
          border = "ffffffff";
        };

        border = {
          width = "2";
        };
      };
    };
  };
}
