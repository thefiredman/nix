{
  disko.devices = {
    disk = {
      foozilla = {
        # nveme2n1
        # 1TB
        device = "/dev/disk/by-id/nvme-eui.e8238fa6bf530001001b448b472e6a41";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            gaming = {
              start = "0";
              end = "-10G";
              content = {
                type = "filesystem";
                format = "xfs";
              };
            };
          };
        };
      };
    };
  };
}
