{ lib, inputs, withSystem, ... }: {
  _module.args = {
    darwinGenesis = architecture: hostName: extraModules:
      let
        specialArgs = withSystem architecture
          ({ pkgs, inputs', self', ... }: { inherit self' inputs' inputs; });
      in inputs.nix-darwin.lib.darwinSystem {
        inherit specialArgs;

        modules = [
          {
            nixpkgs = { hostPlatform = architecture; };

            home-manager.extraSpecialArgs = specialArgs;
          }

          inputs.home-manager.darwinModules.home-manager
          inputs.self.nixosModules.genesis
          inputs.self.nixosModules.darwin

          {
            genesis = {
              architecture = "${architecture}";
              hostName = "${hostName}";
            };
          }
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
            nixpkgs = { hostPlatform = architecture; };
            home-manager.extraSpecialArgs = specialArgs;
          }

          inputs.home-manager.nixosModules.home-manager
          inputs.self.nixosModules.nixos
          inputs.self.nixosModules.genesis
          inputs.disko.nixosModules.disko
          inputs.impermanence.nixosModules.impermanence

          {
            genesis = {
              architecture = "${architecture}";
              hostName = "${hostName}";
            };
          }
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
              alacritty
              wezterm
              kitty
              foot
              dev
              git
              tmux
              fzf
              fd
              fish
              lsd
              fuzzel
              river
              hyprland
              scripts
              nixCats
            ] ++ homeConfiguration;

          home.stateVersion = lib.mkForce "24.05";
        };

        users.users.${userName} = {
          name = "${userName}";
          home = "${homePath}";
        };
      };

    homeLinux = userName: homeConfiguration:
      let homePath = "/home/${userName}";
      in {
        imports = [ ./genesis/linux-home.nix ];
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
                wezterm
                alacritty
                foot
                dev
                git
                tmux
                fzf
                fd
                fish
                river
                hyprland
                fuzzel
                lsd
                xdg
                scripts
                nixCats
              ] ++ homeConfiguration;
          };
        };

        users.users.${userName} = {
          name = "${userName}";
          home = "${homePath}";
          isNormalUser = true;
          initialPassword = "boobs";
          extraGroups = [ "wheel" "video" "networkmanager" ];
        };
      };
  };
}
