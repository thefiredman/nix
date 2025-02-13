{ config, ... }: {
  environment.shellAliases = {
    upgrade =
      "darwin-rebuild switch --flake ${config.systemGenesis.configDir}#${config.systemGenesis.hostName}";
    bootgrade =
      "darwin-rebuild build --flake ${config.systemGenesis.configDir}#${config.systemGenesis.hostName}";
    update = "nix flake update ${config.systemGenesis.configDir}";
    cleanup = "nix-collect-garbage -d && nix store optimise";
  };
}
