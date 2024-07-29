{ pkgs, ... }: {
  boot = {
    initrd.availableKernelModules =
      [ "uhci_hcd" "ahci" "xhci_pci" "nvme" "usbhid" "sr_mod" ];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.interfaces.ens160.useDHCP = true;
}
