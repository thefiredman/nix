{ config, lib, pkgs, ... }: {
  options.h = { tmux.enable = lib.mkEnableOption "Enable tmux."; };

  config = lib.mkIf config.h.tmux.enable {
    environment.systemPackages = with pkgs; [ tmux-sessionizer ];

    home-manager.users.${config.h.username} = {
      xdg.configFile = {
        "tms/config.toml".text = ''
          [[search_dirs]]
          path = "${config.h.configHome}/"
          depth = 5

          [[search_dirs]]
          path = "${config.h.homePath}/${config.h.nixHome}/"
          depth = 2

          [[search_dirs]]
          path = "${config.h.homePath}/${config.h.devHome}/"
          depth = 20

          [[excluded_dirs]]
          path = ".direnv"
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
  };
}
