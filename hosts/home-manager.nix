{ config, inputs, ... }:
let homePath = "/${config.homeRoot}/${config.userName}";
in {
  home-manager.users.${config.userName} = {
    imports = with inputs.self.homeModules; [
      { h.homePath = "${homePath}"; }
      paths
      kitty
      dev
      git
      tmux
      fzf
      fd
      fish
      bash
      lsd
      scripts
    ];

    home = { stateVersion = "24.05"; };
  };

  programs.direnv = {
    silent = true;
    enable = true;
    nix-direnv.enable = true;
  };

  users.users.${config.userName} = {
    name = "${config.userName}";
    home = "${homePath}";
    inherit (config.h) shell;
  };
}
