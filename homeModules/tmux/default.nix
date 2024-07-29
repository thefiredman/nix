{ config, lib, pkgs, ... }: {
  options.h.tmux = {
    enable = lib.mkEnableOption "Enable tmux." // { default = true; };
  };

  config = lib.mkIf config.h.tmux.enable {
    programs.tmux = {
      enable = true;
      keyMode = "vi";
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
