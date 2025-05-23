{ lib, config, pkgs, ... }: {
  options.h.wmenu = {
    config = lib.mkOption {
      type = lib.types.str;
      default = "-f 'monospace 21' -s '#ffffff' -S '#b16286' -N '#000000'";
    };

    pipe = lib.mkOption {
      type = lib.types.package;
      default = pkgs.writeShellScriptBin "wmenu" ''
        exec ${lib.getExe' pkgs.wmenu "wmenu"} ${config.h.wmenu.config}
      '';
    };

    run = lib.mkOption {
      type = lib.types.package;
      default = pkgs.writeShellScriptBin "wmenu-run" ''
        exec ${lib.getExe' pkgs.wmenu "wmenu-run"} ${config.h.wmenu.config}
      '';
    };
  };
}
