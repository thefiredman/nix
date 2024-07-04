{ config, lib, pkgs, ... }: {
  options.h = { fish.enable = lib.mkEnableOption "Enable fish."; };

  config = lib.mkIf config.h.fish.enable {
    programs.fish = { enable = true; };

    home-manager.users.${config.h.username} = {
      xdg.configFile = {
        "fish/themes/fishsticks.theme".source = ./fishsticks.theme;
      };

      programs.fish = {
        enable = true;
        shellInit = builtins.readFile ./config.fish;
        interactiveShellInit = builtins.readFile ./map.fish;
        functions = {
          fish_mode_prompt = {
            body = "";
            onEvent = null;
          };
          fish_prompt = {
            body = ''
              printf '%s%s%s %s%s%s\n%s ' \
                (set_color ${config.h.shell.prefix_colour})(whoami)\
                (set_color "brwhite")@\
                (set_color "bryellow")(hostname)\
                (set_color "brgreen") (prompt_pwd) \
                (set_color "brred"; fish_git_prompt) \
                (set_color normal)🍺
            '';
            onEvent = null;
          };
        };
        plugins = [
          {
            name = "autopair";
            inherit (pkgs.fishPlugins.autopair) src;
          }
          {
            name = "puffer";
            inherit (pkgs.fishPlugins.puffer) src;
          }
        ];
      };
    };
  };
}
