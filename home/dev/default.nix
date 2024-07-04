{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      # editor
      tree-sitter
      zola
      ripgrep

      # languages
      nodePackages_latest.npm
      nodejs
      go
      jdk21

      # lsp's
      vscode-langservers-extracted
      nil
      nixd
      nixpkgs-fmt
      nixfmt-classic
      rust-analyzer
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
      xcodes

      # util
      smartmontools
      imagemagick
    ];
  };

  home-manager.users.${config.h.username} = {
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
      sessionVariables = {
        GOPATH = "${config.h.dataHome}/go";
        NPM_CONFIG_PREFIX = "${config.h.dataHome}/npm";
        NPM_CONFIG_USERCONFIG = "${config.h.configHome}/npm/config";
        CARGO_HOME = "${config.h.dataHome}/cargo";
        LESSHISTFILE = "/dev/null";
      };

      sessionPath = [ "$NPM_CONFIG_PREFIX/bin" "$CARGO_HOME/bin" ];
    };
  };
}
