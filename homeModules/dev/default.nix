{ config, pkgs, lib, ... }: {
  options.h.dev = {
    enable = lib.mkEnableOption "Enable development tools." // {
      default = true;
    };
  };

  config = lib.mkIf config.h.dev.enable {
    xdg = {
      configFile = {
        # I love npm
        "npm/config".text = ''
          cache=${config.h.cacheHome}/npm
        '';
      };
    };

    programs.neovim = {
      extraLuaPackages = ps: with ps; [ jsregexp ];
      extraPackages = with pkgs; [ lua51Packages.lua luarocks ];

      enable = true;
      defaultEditor = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = false;
    };

    home = {
      sessionVariables = with pkgs; {
        SHELL = "${lib.getBin config.h.shell.package}/bin/${
            lib.getName config.h.shell.package
          }";
        GOPATH = "${config.h.dataHome}/go";
        NPM_CONFIG_PREFIX = "${config.h.dataHome}/npm";
        NPM_CONFIG_USERCONFIG = "${config.h.configHome}/npm/config";
        CARGO_HOME = "${config.h.dataHome}/cargo";
        LESSHISTFILE = "/dev/null";
        JDK17 = jdk17;
        JDK21 = jdk21;
      };

      packages = with pkgs; [
        # editor
        tree-sitter
        zola
        ripgrep

        # languages
        nodePackages_latest.npm
        nodejs
        go

        # basic compilers for nvim
        gcc
        cmake

        # lsp's
        vscode-langservers-extracted
        nil
        nixd
        nixpkgs-fmt
        nixfmt-classic
        lua-language-server
        nodePackages_latest.typescript-language-server
        nodePackages_latest.live-server
        emmet-ls
        marksman

        # fmt + linter
        deadnix
        statix
        editorconfig-checker
        ruff
        mypy
        shellcheck
        jq
        yq
        typstfmt
        shfmt
        stylua

        # apple
        # lemon.xcodes

        # util
        smartmontools
        imagemagick
      ];

      sessionPath = [ "$NPM_CONFIG_PREFIX/bin" "$CARGO_HOME/bin" ];
    };
  };
}
