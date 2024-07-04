{ config, lib, ... }: {
  options.h = { git.enable = lib.mkEnableOption "Enable git."; };

  config = lib.mkIf config.h.git.enable {
    home-manager.users.${config.h.username} = {
      programs.git = {
        enable = true;
        userName = "daslastic";
        userEmail = "daslastic@gmail.com";
        ignores = [ ".DS_Store" ];
      };
    };
  };
}
