{
  disko.devices = {
    disk = {
      pooh = {
        type = "disk";
        device = "/dev/disk/by-id/usb-SanDisk_Portable_SSD_323432353639343030363731-0:0";
        content = {
          type = "gpt";
          partitions = {
            pooh = {
              label = "POOH";
              size = "100%";
              content = {
                type = "zfs";
                pool = "pooh";
              };
            };
          };
        };
      };
    };
    zpool = {
      pooh = {
        type = "zpool";
        options = {
          autotrim = "off";
          ashift = "12";
        };
        rootFsOptions = {
          compression = "zstd";
          acltype = "posixacl";
          atime = "off";
          xattr = "sa";
          normalization = "formD";
          mountpoint = "none";
          canmount = "off";
          encryption = "aes-256-gcm";
          keyformat = "hex";
          keylocation = "file:///mnt/a/keys/b.key";
          sync = "disabled";
          dnodesize = "auto";
        };
        datasets = {
          b = {
            type = "zfs_fs";
            options.mountpoint = "/mnt/b";
            mountpoint = "/mnt/b";
          };
          reserved = {
            type = "zfs_fs";
            options = {
              mountpoint = "none";
              reservation = "10G";
            };
          };
        };
      };
    };
  };
}
