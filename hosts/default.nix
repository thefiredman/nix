{ inputs, ... }:

let
  inextricables = with inputs.self.nixosModules; [
    nixsys
    darwin
  ];

  macGenesis = args:
    (inputs.nix-darwin.lib.darwinSystem
      ((builtins.removeAttrs args [ "hostName" "userName" ]) // {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; } // args.specialArgs or { };
        modules = (args.modules or [ ]) ++ [
          inputs.home-manager.darwinModules.home-manager
          ./home-manager.nix
          {
            host = "${args.hostName}";
            architecture = "${args.system}";
            modules = { darwin.enable = true; };
            userName = "${args.userName}";
          }
        ] ++ inextricables;
      }));
in {
  flake = {
    darwinConfigurations = {
      refrigerator = macGenesis {
        hostName = "refrigerator";
        userName = "shalev";
        modules = [ ./refrigerator { } ];
      };
    };

    nixosConfigurations = { };
  };
}
