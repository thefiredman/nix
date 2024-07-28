{ pkgs, ...}: {
  hardware =  {
    graphics.enable = true;
  };

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "CascadiaCode" "IosevkaTerm" ]; })
    ];
  };
}

