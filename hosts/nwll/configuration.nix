{ pkgs, lib, inputs, ... }: {
  users.users.dashalev = {
    uid = 1000;
    extraGroups = [ "wheel" "video" "networkmanager" ];
    initialPassword = "boobs";
  };

  security.sudo.wheelNeedsPassword = false;

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.systemd.enable = true;
  };

  systemd.targets =
    lib.genAttrs [ "sleep" "suspend" "hibernate" "hybrid-sleep" ]
    (_: { enable = lib.mkForce false; });

  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      liberation_ttf
      # luculent
      iosevka
      inter
      inputs.apple-emoji-linux.packages.${pkgs.system}.apple-emoji-linux
      cascadia-code
      nerd-fonts.symbols-only
    ];

    fontconfig = {
      enable = true;
      hinting.enable = false;
      defaultFonts = {
        serif = [ "Inter" ];
        sansSerif = [ "Inter" ];
        monospace = [ "Iosevka" "Symbols Nerd Font Mono" ];
        # monospace = [ "Cascadia Code" "Symbols Nerd Font Mono" ];
        emoji = [ "Apple Color Emoji" ];
      };
    };
  };

  system.stateVersion = "24.05";
}
