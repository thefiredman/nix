{ lib, pkgs, ... }: {
  boot = {
    initrd.availableKernelModules =
      [ "uhci_hcd" "ahci" "xhci_pci" "nvme" "usbhid" "sr_mod" ];
  };

  networking.useDHCP = lib.mkDefault true;
}
