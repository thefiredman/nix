{ config, options, lib, ... }: {
  config = lib.mkMerge [
    (lib.mkIf (options.environment ? persistence) {
      environment.persistence."/persist" = {
        enable = true;
        hideMounts = true;
        directories =
          [ "/var/lib/nixos" "/var/log" "/var/lib/systemd/coredump" ];
      };
    })
    {
      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
        initrd.systemd.enable = lib.mkDefault true;
      };

      networking = {
        firewall.enable = lib.mkDefault false;
        useDHCP = lib.mkDefault true;
        hostId = lib.mkDefault (builtins.substring 0 8
          (builtins.hashString "md5" config.networking.hostName));
      };

      users.mutableUsers = lib.mkDefault false;

      security = {
        polkit.enable = lib.mkForce true;
        rtkit.enable = lib.mkForce config.services.pipewire.enable;
      };

      services = {
        fstrim.enable = lib.mkForce true;
        pulseaudio.enable = lib.mkForce false;
        earlyoom.enable = lib.mkForce true;
        udisks2.enable = lib.mkForce true;
        dbus.implementation = lib.mkForce "broker";
        pipewire = {
          inherit (config.hardware.graphics) enable;
          pulse.enable = true;
          alsa = {
            enable = true;
            support32Bit = true;
          };
          jack.enable = true;
        };
      };

      programs = {
        dconf = { inherit (config.hardware.graphics) enable; };
        direnv.enable = lib.mkForce true;
        command-not-found.enable = lib.mkForce false;
        fuse.userAllowOther = true;
        git = {
          enable = lib.mkForce true;
          lfs.enable = lib.mkDefault true;
        };
      };

      documentation = {
        enable = lib.mkForce true;
        man.enable = lib.mkForce true;
        doc.enable = lib.mkForce false;
        nixos.enable = lib.mkForce false;
        info.enable = lib.mkForce false;
      };
    }
  ];
}
