{ config, lib, pkgs, ... }: {
  options.h.tmux = {
    enable = lib.mkEnableOption "Enable tmux." // { default = true; };
  };

  config = lib.mkIf config.h.tmux.enable {
    home.packages = with pkgs; [ tmux-sessionizer ];
    xdg.configFile = {
      "tms/config.toml".text = ''
        excluded_dirs = [".direnv"]

        [[search_dirs]]
        path = "${config.h.configHome}/"
        depth = 5
      '';
    };

    programs.tmux = {
      enable = true;
      keyMode = "vi";
      terminal = "screen-256color";
      mouse = true;
      prefix = "C-b";
      sensibleOnTop = false;
      baseIndex = 1;
      disableConfirmationPrompt = true;
      customPaneNavigationAndResize = true;
      extraConfig = builtins.readFile ./tmux.conf;
      plugins = with pkgs.tmuxPlugins; [ yank vim-tmux-navigator ];
    };
  };
}
