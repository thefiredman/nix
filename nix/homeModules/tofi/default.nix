{ config, lib, ... }: {
  options.h.tofi = {
    enable = lib.mkEnableOption "Enables Tofi Menu." // { default = false; };
  };

  config = lib.mkIf config.h.tofi.enable {
    programs.tofi = {
      enable = true;
      settings = {
        font = "Monospace";
        font-size = "35";
        outline-width = "0";
        border-width = "0";
        padding-top = "25";
        padding-bottom = "25";
        padding-left = "40";
        padding-right = "40";
        background-color = "#111";
        text-color = "#f9fbff";
        selection-color = "blue";
        width = "20%";
        height = "20%";
        prompt-text = "\"\"";
        hide-cursor = false;
      };
    };
  };
}
