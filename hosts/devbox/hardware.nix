{ lib, modulesPath, ... }: {
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];
  boot.initrd.availableKernelModules = [ "xhci_pci" "sr_mod" ];
  networking.useDHCP = lib.mkDefault true;
}
