{ config, pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      dash
      tracy
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

    shells = [ pkgs.dash ];
    loginShell = pkgs.dash;

    variables = { SHELL = "${pkgs.dash}/bin/dash"; };
  };

  home-manager.users.${config.h.username} = {
    home.shellAliases = {
      vim = "nvim";
      vi = "nvim";
      tree = "tree -C";
    };
  };
}
