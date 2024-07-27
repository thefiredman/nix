{ pkgs, ... }: {
  security.pki.installCACerts = false;

  environment = {
    shells = [ pkgs.fish ];
    loginShell = pkgs.fish;
  };

  fonts = {
    packages = with pkgs; [
      # NOTE: IosevkaTerm
      (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
      lato
      ibm-plex
    ];
  };

  system = {
    defaults = {
      CustomSystemPreferences = { };
      CustomUserPreferences = {
        "com.apple.WindowManager" = {
          StageManagerHideWidgets = 1;
          StandardHideWidgets = 1;
        };
      };

      LaunchServices.LSQuarantine = false;
      NSGlobalDomain = {
        # you can move windows by holding ctrl+cmd
        NSWindowShouldDragOnGesture = true;
        # https://github.com/LnL7/nix-darwin/blob/230a197063de9287128e2c68a7a4b0cd7d0b50a7/modules/system/defaults/NSGlobalDomain.nix
        AppleShowScrollBars = "Automatic";
        AppleInterfaceStyle = "Dark";
        ApplePressAndHoldEnabled = false;
        AppleShowAllExtensions = false;
        AppleShowAllFiles = true;

        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSDocumentSaveNewDocumentsToCloud = false;
        AppleTemperatureUnit = "Celsius";

        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;
        "com.apple.swipescrolldirection" = false;
      };

      spaces = { spans-displays = false; };

      trackpad = {
        Clicking = true;
        ActuationStrength = 0;
        FirstClickThreshold = 0;
        SecondClickThreshold = 0;
      };

      dock = {
        autohide = true;
        mru-spaces = false;
        autohide-time-modifier = 0.1;
        autohide-delay = 0.0;
        persistent-apps = [
          "/Applications/Safari.app"
          "/System/Applications/Mail.app"
          "/System/Applications/Messages.app/"
          "/System/Applications/Music.app"
          "/Applications/Infuse.app"
        ];
        show-process-indicators = false;
        showhidden = true;
        minimize-to-application = true;
        show-recents = false;
        tilesize = 64;
        wvous-tl-corner = 2;
        wvous-br-corner = 1;
        enable-spring-load-actions-on-all-items = false;
        dashboard-in-overlay = false;
      };

      finder = {
        CreateDesktop = false;
        FXPreferredViewStyle = "clmv";
        FXEnableExtensionChangeWarning = false;
      };

      loginwindow = {
        LoginwindowText = "yo momma gay";
        GuestEnabled = false;
      };
    };

    keyboard = {
      enableKeyMapping = true;
      swapLeftCommandAndLeftAlt = false;
      remapCapsLockToEscape = true;
    };
  };
}
