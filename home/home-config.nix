{ config, ... }: {
  options = { };

  config = {
    # xdg.configHome wasn't working...
    # this is better no cope
    h.homePath = "/${config.sys.homeRoot}/${config.h.username}";
    h.dataHome = "${config.h.homePath}/.local/share";
    h.configHome = "${config.h.homePath}/.config";
    h.cacheHome = "${config.h.homePath}/.cache";
  };
}
