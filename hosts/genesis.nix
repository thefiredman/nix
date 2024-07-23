{ inputs, withSystem, config, ... }: {
  _module.args = {
    darwinGenesis = architecture: hostName: extraModules:
      let
        specialArgs = withSystem architecture
          ({ inputs', self', ... }: { inherit self' inputs' inputs; });
      in inputs.nix-darwin.lib.darwinSystem {
        inherit specialArgs;
        modules = [
          {
            nixpkgs.hostPlatform = architecture;
            home-manager.extraSpecialArgs = specialArgs;
            genesis = {
              architecture = "${architecture}";
              hostName = "${hostName}";
            };
          }

          inputs.home-manager.darwinModules.home-manager
          inputs.self.nixosModules.global
          inputs.self.nixosModules.darwin
        ] ++ extraModules;
      };

    linuxGenesis = architecture: hostName: extraModules:
      let
        specialArgs = withSystem architecture
          ({ inputs', self', ... }: { inherit self' inputs' inputs; });
      in inputs.nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          inputs.home-manager.nixosModules.home-manager
          {
            nixpkgs.hostPlatform = architecture;
            home-manager.extraSpecialArgs = architecture;
            genesis = {
              architecture = "${architecture}";
              hostName = "${hostName}";
            };
          }

          inputs.self.nixosModules.global
        ] ++ extraModules;
      };

    homeGenesis = userName: homeRoot: homeConfiguration:
      let homePath = "/${homeRoot}/${userName}";
      in {
        home-manager.users.${userName} = {
          imports = with inputs.self.homeModules;
            [
              { h.homePath = "${homePath}"; }
              paths
              kitty
              dev
              git
              tmux
              fzf
              fd
              fish
              lsd
              scripts
            ] ++ homeConfiguration;

          home = { stateVersion = "24.11"; };
        };

        users.users.${userName} = {
          name = "${userName}";
          home = "${homePath}";
          inherit (config.h) shell;
        };
      };
  };
}
