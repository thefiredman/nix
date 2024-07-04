{ lib, ... }: {
  options = {
    h = {
      username = lib.mkOption {
        type = with lib.types; str;
        default = "shalev";
        description = "This is your username, choose wisely.";
      };
      shell = {
        prefix_colour = lib.mkOption {
          type = with lib.types; str;
          # this color looks bad on purpose,
          # define it so your system has a unique color
          default = "red";
          description = "Your shell color.";
        };
      };
      homePath = lib.mkOption {
        type = with lib.types; str;
        description = "Your systems home path. Must be defined explicitly.";
      };
      devHome = lib.mkOption {
        type = with lib.types; str;
        # ~ is implicit
        default = "dev";
        description = "Development Directory.";
      };
      nixHome = lib.mkOption {
        type = with lib.types; str;
        # ~ is implicit
        default = "nix";
        description = "Nix's root. Your nix configuration should be here.";
      };
      dataHome = lib.mkOption {
        type = with lib.types; str;
        description = "XDG_DATAHOME. Must be defined explicitly.";
      };
      configHome = lib.mkOption {
        type = with lib.types; str;
        description = "XDG_CONFIGHOME. Must be defined explicitly.";
      };
      cacheHome = lib.mkOption {
        type = with lib.types; str;
        description = "XDG_CACHEHOME. Must be defined explicitly.";
      };
    };
    sys = {
      host = lib.mkOption {
        type = with lib.types; str;
        description = "This is your host name. Must be defined explicitly.";
      };
      system = lib.mkOption {
        type = with lib.types; str;
        description = "Your systems architecture. Must be defined explicitly.";
      };
      homeRoot = lib.mkOption {
        type = with lib.types; str;
        description =
          "Your systems root home path. Must be defined explicitly.";
      };
    };
  };
}
