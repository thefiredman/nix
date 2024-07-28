{ inputs, withSystem, lib, ... }: {
  _module.args = {
    darwinGenesis = architecture: hostName: extraModules:
      let
        specialArgs = withSystem architecture
          ({ pkgs, inputs', self', ... }: { inherit self' inputs' inputs; });
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
          inputs.self.nixosModules.genesis
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
          {
            nixpkgs.hostPlatform = architecture;
            home-manager.extraSpecialArgs = specialArgs;
            genesis = {
              architecture = "${architecture}";
              hostName = "${hostName}";
            };
          }

          inputs.home-manager.nixosModules.home-manager
          inputs.self.nixosModules.nixos
          inputs.self.nixosModules.genesis
          inputs.disko.nixosModules.disko
        ] ++ extraModules;
      };

    homeDarwin = architecture: userName: homeConfiguration:
      let homePath = "/Users/${userName}";
      in {
        home-manager.users.${userName} = {
          imports = with inputs.self.homeModules;
            [
              {
                h = {
                  homePath = "${homePath}";
                  userName = "${userName}";
                };
              }
              paths
              kitty
              foot
              dev
              git
              tmux
              fzf
              fd
              fish
              lsd
              tofi
              river
              scripts
            ] ++ homeConfiguration;

          home.stateVersion = lib.mkForce "24.11";
        };

        users.users.${userName} = {
          name = "${userName}";
          home = "${homePath}";
        };
      };

    homeLinux = userName: homeConfiguration:
      let homePath = "/home/${userName}";
      in {
        imports = [ ./linux-home.nix ];
        home-manager = {
          users.${userName} = {
            imports = with inputs.self.homeModules;
              [
                {
                  h = {
                    homePath = "${homePath}";
                    userName = "${userName}";
                  };
                }
                paths
                kitty
                foot
                dev
                git
                tmux
                fzf
                fd
                fish
                river
                tofi
                lsd
                scripts
              ] ++ homeConfiguration;
          };
        };

        users.users.${userName} = {
          name = "${userName}";
          home = "${homePath}";
          isNormalUser = true;
          initialPassword = "boobs";
          extraGroups = [ "wheel" "video" ];
        };
      };
  };
}
