{ pkgs, ... }: {
  services = {
    # postgresql = { enable = false; };
    mullvad-vpn.enable = true;
    # greetd = {
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
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config.common = {
      default = [ "wlr" ];
      river = [ "wlr" ];
    };
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs = {
    obs-studio = {
      enable = true;
      plugins = [
        pkgs.obs-studio-plugins.wlrobs
        pkgs.obs-studio-plugins.obs-vkcapture
      ];
    };
    adb.enable = true;
    steam.enable = true;
    gamescope = {
      enable = true;
      args = [ "--hdr-enabled" ];
    };
    nh = {
      enable = true;
      clean.enable = true;
    };

    gnupg.agent = { enable = true; };
    fish.enable = true;
    # chromium = {
    #   enable = true;
    #   extensions = [
    #     "nngceckbapebfimnlniiiahkandclblb" # bitwarden
    #     "faeadnfmdfamenfhaipofoffijhlnkif" # into the black hole
    #   ];
    #   extraOpts = {
    #     "DefaultSearchProviderEnabled" = true;
    #     "BrowserLabsEnabled" = false;
    #     "GenAiDefaultSettings" = 2;
    #     "BookmarkBarEnabled" = false;
    #     "ImportBookmarks" = false;
    #     "PromotionsEnabled" = false;
    #     "BrowserSignin" = 0;
    #     "DefaultBrowserSettingEnabled" = false;
    #     "AutoSignInEnabled" = true;
    #     "BrowserAddPersonEnabled" = false;
    #     "BrowserGuestModeEnabled" = false;
    #     "UserFeedbackAllowed" = false;
    #     "BackgroundModeEnabled" = false;
    #     "MetricsReportingEnabled" = false;
    #     "BlockExternalExtensions" = true;
    #     "AutofillAddressEnabled" = false;
    #     "AutofillCreditCardEnabled" = false;
    #     "PasswordManagerEnabled" = false;
    #     "PromptForDownloadLocation" = true;
    #     "SyncDisabled" = true;
    #     "SpellcheckEnabled" = true;
    #   };
    # };
  };
}
