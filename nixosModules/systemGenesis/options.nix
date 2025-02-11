{ lib, ... }: {
  options = {
    systemGenesis = {
      hostName = lib.mkOption {
        type = with lib.types; nonEmptyStr;
        description = "This is your host name. Must be defined explicitly.";
      };

      architecture = lib.mkOption {
        type = with lib.types; nonEmptyStr;
        description = "Your systems architecture. Must be defined explicitly.";
      };

      configDir = lib.mkOption {
        type = with lib.types; nonEmptyStr;
        default = "$HOME/.config/nix";
        description = "Configuration location for rebuild aliases.";
      };
    };
  };
}
