{ config, lib, pkgs, ... }: {
  imports = [
    # VITAL
    ./home-config.nix
    ./global.nix
    ./dev
    ./fd

    ./fish
    ./kitty
    ./tmux
    ./git
    ./lsd
    ./scripts
    {
      h = {
        kitty.enable = lib.mkDefault true;
        fish.enable = lib.mkDefault true;
        lsd.enable = lib.mkDefault true;
        git.enable = lib.mkDefault true;
        tmux.enable = lib.mkDefault true;
      };
    }
  ];

  programs.direnv = {
    silent = true;
    enable = true;
    nix-direnv.enable = true;
  };

  users.users.${config.h.username} = {
    name = "${config.h.username}";
    home = "${config.h.homePath}";
  };

  home-manager.users.${config.h.username} = {
    programs = {
      nix-index = { enable = false; };
      fzf = {
        enable = true;
        tmux.enableShellIntegration = false;
        enableFishIntegration = false;
        enableBashIntegration = false;
        enableZshIntegration = false;
        defaultOptions = [ "--height 100%" "--layout=reverse" "--exact" ];
      };
    };

    xdg = {
      enable = true;
      configHome = "${config.h.configHome}";
      dataHome = "${config.h.dataHome}";
    };

    home = {
      stateVersion = "24.05";
      sessionVariables = { SHELL = "${pkgs.fish}/bin/fish"; };
    };
  };
}
