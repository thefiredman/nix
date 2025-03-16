{ pkgs, lib, config, ... }: {
  environment.persistence."/nix/persist" = {
    directories = [
      "/var/lib/bluetooth/"
      "/var/lib/NetworkManager/"
      "/etc/NetworkManager/"
    ];
  };

  # mount gaming drive if there
  fileSystems."/mnt/b" = {
    device = "/dev/sda1";
    fsType = "xfs";
    options = [ "defaults" "nofail" ];
  };

  networking.networkmanager = { enable = true; };
  systemd.services.NetworkManager-wait-online.wantedBy = lib.mkForce [ ];

  services = {
    xserver.videoDrivers = [ "nvidia" ];
    blueman.enable = true;
    scx = {
      enable = true;
      package = pkgs.scx-full_git;
      scheduler = "scx_lavd";
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    tmp.cleanOnBoot = true;
  };

  powerManagement.cpuFreqGovernor = "performance";

  hardware = {
    enableAllFirmware = lib.mkForce true;
    wirelessRegulatoryDatabase = true;
    bluetooth = {
      inherit (config.hardware.graphics) enable;
      powerOnBoot = lib.mkDefault true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ nvidia-vaapi-driver ];
      extraPackages32 = with pkgs; [ nvidia-vaapi-driver ];
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = false;
        finegrained = false;
      };

      open = true;
      nvidiaSettings = false;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };

  boot = {
    initrd.availableKernelModules =
      [ "nvme" "xhci_pci" "thunderbolt" "usbhid" "usb_storage" "uas" ];
  };

  networking.useDHCP = lib.mkDefault true;
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
