{ config, lib, ... }: {
  options.h.git = {
    enable = lib.mkEnableOption "Enable git." // { default = true; };
  };

  config = lib.mkIf config.h.git.enable {
    programs.git = {
      enable = true;
      userName = "daslastic";
      userEmail = "daslastic@gmail.com";
      ignores = [ ".DS_Store" ];
    };
  };
}
