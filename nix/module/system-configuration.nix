{
  nix = {
    optimise = {
      automatic = true;
    };
    settings = {
      builders-use-substitutes = true;
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-users = [
        "@wheel"
        "dlvhdr"
      ];
      warn-dirty = false;
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
    };
  };

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
    defaults = {
      ".GlobalPreferences"."com.apple.mouse.scaling" = -1.0;
      trackpad = {
        Clicking = true;
        TrackpadThreeFingerTapGesture = 0;
      };
      menuExtraClock.Show24Hour = true;
      WindowManager.EnableStandardClickToShowDesktop = false;
      dock = {
        wvous-br-corner = 1;
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.0;
        orientation = "bottom";
        tilesize = 42;
        showhidden = true;
        show-recents = true;
        show-process-indicators = true;
        expose-animation-duration = 0.1;
        expose-group-apps = true;
        launchanim = false;
        mineffect = "scale";
        mru-spaces = false;
        persistent-apps = [
          "/Applications/Ghostty.app"
          "/Applications/Arc.app"
          "/System/Applications/Mail.app"
          "/Applications/Notion Calendar.app"
          "/Applications/Slack.app"
          "/Applications/Obsidian.app"
          "/Applications/1Password.app"
        ];
      };
      screencapture = {
        disable-shadow = true;
        location = "~/Pictures/Screenshots";
        type = "jpg";
      };
      NSGlobalDomain = {
        "com.apple.springing.delay" = 0.0;
        "com.apple.swipescrolldirection" = false;
        AppleInterfaceStyle = "Dark";
        AppleMeasurementUnits = "Centimeters";
        ApplePressAndHoldEnabled = false;
        AppleShowScrollBars = "Always";
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSDocumentSaveNewDocumentsToCloud = false;
        NSTableViewDefaultSizeMode = 2;
        NSWindowResizeTime = 0.1;
        _HIHideMenuBar = false;
      };
      finder = {
        FXPreferredViewStyle = "Nlsv";
        _FXShowPosixPathInTitle = true;
        FXEnableExtensionChangeWarning = false;
        AppleShowAllFiles = true;
        ShowStatusBar = true;
        ShowPathbar = true;
      };
      CustomUserPreferences = {
        "com.apple.NetworkBrowser" = {
          BrowseAllInterfaces = true;
        };
        "com.apple.screensaver" = {
          askForPassword = true;
          askForPasswordDelay = 0;
        };
        "com.apple.trackpad" = {
          scaling = 2;
        };
        "com.apple.mouse" = {
          scaling = -1.0;
        };
        "com.apple.desktopservices" = {
          DSDontWriteNetworkStores = false;
        };
        "com.apple.LaunchServices" = {
          LSQuarantine = true;
        };
        "com.apple.finder" = {
          ShowExternalHardDrivesOnDesktop = false;
          ShowRemovableMediaOnDesktop = false;
          WarnOnEmptyTrash = false;
        };
        "NSGlobalDomain" = {
          NSNavPanelExpandedStateForSaveMode = true;
          NSTableViewDefaultSizeMode = 1;
          WebKitDeveloperExtras = true;
        };
        "com.apple.ImageCapture" = {
          "disableHotPlug" = true;
        };
        # "com.apple.mail" = {
        #   DisableReplyAnimations = true;
        #   DisableSendAnimations = true;
        #   DisableInlineAttachmentViewing = true;
        #   AddressesIncludeNameOnPasteboard = true;
        #   InboxViewerAttributes = {
        #     DisplayInThreadedMode = "yes";
        #     SortedDescending = "yes";
        #     SortOrder = "received-date";
        #   };
        #   NSUserKeyEquivalents = {
        #     Send = "@\U21a9";
        #     Archive = "@$e";
        #   };
        # };
        "com.apple.dock" = {
          size-immutable = true;
        };
      };
    };
  };

}
