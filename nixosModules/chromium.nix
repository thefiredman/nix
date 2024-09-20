{ pkgs, ... }: {
  programs.chromium = {
    enable = true;
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm"
      "nngceckbapebfimnlniiiahkandclblb"
      "faeadnfmdfamenfhaipofoffijhlnkif"
    ];
  };

  environment.systemPackages = with pkgs;
    [
      (chromium.override {
        enableWideVine = true;
        commandLineArgs = [
          "--enable-features=UseOzonePlatform,Vulkan,VaapiVideoEncoder,VaapiVideoDecoder,VaapiIgnoreDriverChecks,VaapiVideoDecodeLinuxGL,CanvasOopRasterization,ParallelDownloading"
          "--ozone-platform-hint=auto"
          "--enable-smooth-scrolling"
        ];
      })
    ];
}
