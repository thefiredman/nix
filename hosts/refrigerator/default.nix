{ pkgs, config, ... }: {
  security.pki.installCACerts = false;

  imports = [
    # specific stuff for this computer
    ./yabai.nix
    ./skhd.nix
    ./apps.nix
    ./scripts.nix
  ];

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "CascadiaCode" "IosevkaTerm" ]; })
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
          StandardHideWidgets = 0;
        };
      };
      LaunchServices.LSQuarantine = false;
      NSGlobalDomain = {
        # https://github.com/LnL7/nix-darwin/blob/230a197063de9287128e2c68a7a4b0cd7d0b50a7/modules/system/defaults/NSGlobalDomain.nix
        AppleShowScrollBars = "Automatic";
        AppleInterfaceStyle = "Dark";
        ApplePressAndHoldEnabled = false;
        AppleShowAllExtensions = false;
        AppleShowAllFiles = true;

        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
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
          "/Applications/Tidal.app"
          "/Applications/Infuse.app"
        ];
        show-process-indicators = false;
        showhidden = true;
        minimize-to-application = true;
        show-recents = false;
        tilesize = 64;
        # mission control on top right corner
        wvous-tl-corner = 2;
        wvous-br-corner = 1;

        # I wish I knew what these mean,
        # the documentation doesn't really explain
        enable-spring-load-actions-on-all-items = false;
        dashboard-in-overlay = false;
      };
      finder = {
        # required for yabai
        CreateDesktop = true;
        FXPreferredViewStyle = "clmv";
        FXEnableExtensionChangeWarning = false;
      };
      loginwindow = {
        LoginwindowText = "yo momma gay";
        GuestEnabled = false;
      };
      screencapture = {
        location = "${config.h.homePath}/Pictures/Screenshots";
      };
    };
    keyboard = {
      enableKeyMapping = true;
      swapLeftCommandAndLeftAlt = false;
      remapCapsLockToEscape = true;
    };
  };
}
