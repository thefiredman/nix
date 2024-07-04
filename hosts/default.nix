{ inputs, ... }:

let
  inextricables = with inputs.self.nixosModules; [ options darwin nixsys ];

  macGenesis = args:
    (inputs.nix-darwin.lib.darwinSystem
      ((builtins.removeAttrs args [ "hostName" ]) // {
        specialArgs = { inherit inputs; } // args.specialArgs or { };
        modules = (args.modules or [ ]) ++ [
          inputs.home-manager.darwinModules.home-manager
          ../home
          {
            sys = {
              host = "${args.hostName}";
              system = "${args.system}";
              darwin.enable = true;
              nix.enable = true;
            };
          }
        ] ++ inextricables;
      }));
in {
  flake = {
    darwinConfigurations = {
      refrigerator = macGenesis {
        system = "aarch64-darwin";
        hostName = "refrigerator";
        modules =
          [ ./refrigerator { config.h.shell.prefix_colour = "magenta"; } ];
      };
    };

    nixosConfigurations = { };
  };
}
