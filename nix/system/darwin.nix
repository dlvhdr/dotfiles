{
  inputs,
  username,
  overlays,
  nix-index-database,
# gh-dash,
}:
system:
let
  pkgs = inputs.nixpkgs.legacyPackages.${system};
  system-config = import ../module/system-configuration.nix { inherit username pkgs; };
  homebrew = import ../module/homebrew.nix;
  home-manager-config = import ../module/home-manager.nix;
in
inputs.darwin.lib.darwinSystem {
  inherit system;

  # modules: allows for reusable code
  # if you want to share a module between different machines (nixOS, macOS, etc.)
  modules = [
    nix-index-database.darwinModules.nix-index
    { nixpkgs.overlays = overlays; }

    # home-manager
    inputs.home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = false;
      home-manager.useUserPackages = true;
      home-manager.users."${username}" = home-manager-config;
    }

    # shareable main system config
    system-config

    # shareable homebrew config
    # (maybe it should be here as it's pretty specific to macOS?)
    homebrew

    # settings
    {
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
  ];

}
