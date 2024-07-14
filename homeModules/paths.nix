{ lib, pkgs, config, ... }: {
  options.h = {
    homePath = lib.mkOption {
      type = with lib.types; str;
      description = "Your systems home path. Must be defined explicitly.";
    };

    dataHome = lib.mkOption {
      type = with lib.types; str;
      description = "XDG_DATA_HOME";
    };

    configHome = lib.mkOption {
      type = with lib.types; str;
      description = "XDG_CONFIG_HOME";
    };

    cacheHome = lib.mkOption {
      type = with lib.types; str;
      description = "XDG_CACHE_HOME";
    };

    shell = {
      package = lib.mkOption {
        type = lib.types.package;
        description = "The users shell.";
      };

      colour = lib.mkOption {
        type = with lib.types; str;
        description = "Your shell color.";
      };

      icon = lib.mkOption {
        type = with lib.types; str;
        description = "Your shell's icon.";
      };
    };
  };

  config = {
    h = {
      dataHome = "${config.h.homePath}/.local/share";
      configHome = "${config.h.homePath}/.config";
      cacheHome = "${config.h.homePath}/.cache";
    };

    programs = {
      nix-index = { enable = false; };

      # slows down HM
      # however putting mancache at ~ is evil
      man.generateCaches = false;
    };

    xdg = {
      enable = true;
      configHome = "${config.h.configHome}";
      dataHome = "${config.h.dataHome}";
    };

    home = {
      packages = with pkgs; [
        dash
        bat
        hyperfine

        ## INFO
        onefetch
        fastfetch
        btop
        htop

        ## UTIL
        tree
        vimv

        ## SUPER IMPORTANT
        sl
      ];

      shellAliases = {
        vim = "nvim";
        vi = "nvim";
        tree = "tree -C";
        cleanup = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
      };
    };
  };
}
