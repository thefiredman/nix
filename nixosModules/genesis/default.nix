{ lib, ... }: {
  imports = [ ./global.nix ];

  options = {
    genesis = {
      hostName = lib.mkOption {
        type = with lib.types; nonEmptyStr;
        description = "This is your host name. Must be defined explicitly.";
      };

      architecture = lib.mkOption {
        type = with lib.types; nonEmptyStr;
        description = "Your systems architecture. Must be defined explicitly.";
      };

      nixConfig = lib.mkOption {
        type = with lib.types; nonEmptyStr;
        default = "~/nix/";
        description = "Configuration location important for rebuilds.";
      };
    };
  };
}
