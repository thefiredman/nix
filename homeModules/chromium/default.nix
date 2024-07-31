{ config, lib, ... }: {
  options.h.chromium = {
    enable = lib.mkEnableOption "Enables chromium browser." // {
      default = false;
    };
  };

  config = lib.mkIf config.h.chromium.enable {
    programs.chromium = {
      enable = true;
      commandLineArgs = [
        "--enable-features=UseOzonePlatform,Vulkan,VaapiVideoEncoder,VaapiVideoDecoder,VaapiIgnoreDriverChecks,VaapiVideoDecodeLinuxGL,CanvasOopRasterization,ParallelDownloading"
        "--ozone-platform-hint=auto"
        "--enable-unsafe-webgpu"
      ];
      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm"
        "nngceckbapebfimnlniiiahkandclblb"
      ];
    };
  };
}
