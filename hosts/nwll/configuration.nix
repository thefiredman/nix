{ inputs, lib, pkgs, ... }: {
  # services.greetd = {
  #   enable = true;
  #   restart = false;
  #   settings = rec {
  #     initial_session = {
  #       command = "${pkgs.river}/bin/river";
  #       user = "dashalev";
  #     };
  #     default_session = initial_session;
  #   };
  # };

  environment.systemPackages = with pkgs; [
    vesktop
    onlyoffice-desktopeditors
    lorien
    krita
    zed-editor
    inputs.self.packages.${pkgs.system}.cider2
    aseprite
    wacomtablet
    gnome-calendar
    gnome-calculator
    gnome-contacts
    (writeShellApplication {
      name = "gnome-login";
      text = ''
        XDG_CURRENT_DESKTOP=GNOME WEBKIT_DISABLE_COMPOSITING_MODE=1 ${pkgs.gnome-control-center}/bin/gnome-control-center
      '';
    })
  ];

  programs = { geary.enable = true; };
  services = {
    gnome = {
      gnome-keyring.enable = true;
      gnome-online-accounts.enable = true;
    };
  };

  security.sudo.wheelNeedsPassword = false;
  users.users.dashalev = {
    shell = pkgs.fish;
    uid = 1000;
  };

  fonts = {
    packages = with pkgs; [
      corefonts
      inter
      inputs.self.packages.${pkgs.system}.apple-emoji
      (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Inter" ];
        sansSerif = [ "Inter" ];
      };
    };
  };
}
