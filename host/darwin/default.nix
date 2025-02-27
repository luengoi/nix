{ pkgs, target, ... }:

{
  nix = {
    enable = true;
    package = pkgs.nix;

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ "@admin" ];
    };
  };

  environment = {
    shells = with pkgs; [ zsh ];
    pathsToLink = [ "/share/zsh" ];
  };

  programs.zsh.enable = true;

  system = {
    stateVersion = target.host.stateVersion;

    # Global macOS System Settings
    defaults = {
      # Dark Mode
      NSGlobalDomain.AppleInterfaceStyle = "Dark";
      # Force 24-hour time
      NSGlobalDomain.AppleICUForce24HourTime = true;

      CustomUserPreferences = {
        NSGlobalDomain = {
          # Save to disk (not to iCloud) by default
          NSDocumentSaveNewDocumentsToCloud = false;
          # Disable automatic capitalization
          NSAutomaticCapitalizationEnabled = false;
          # Disable smart dashes
          NSAutomaticDashSubstitutionEnabled = false;
          # Disable automatic period
          NSAutomaticPeriodSubstitutionEnabled = false;
          # Disable smart quotes
          NSAutomaticQuoteSubstitutionEnabled = false;
          # Disable auto-correct
          NSAutomaticSpellingCorrectionEnabled = false;
          # Disable press-and-hold in favor of key repeat
          ApplePressAndHoldEnabled = false;
          # Faster keyboard repeat rate
          KeyRepeat = 2;
          InitialKeyRepeat = 25;
          # Enable subpixel font rendering on non-Apple LCDs
          AppleFontSmoothing = 2;
          # Finder: show all filename extensions
          AppleShowAllExtensions = true;
          # Disable beep sound
          "com.apple.sound.beep.feedback" = 0;
        };
        "com.apple.systempreferences" = {
          # Disable Resume system-wide
          NSQuitAlwaysKeepsWindows = false;
        };
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.AdLib" = {
          # Disable personalized advertising
          allowApplePersonalizedAdvertising = false;
        };
      };

      dock = {
        # Automatically hide and show the Dock
        autohide = true;
        # Magnified icon size on hover.
        largesize = 60;
        # Make dock icons of hidden applications translucent
        showhidden = true;
        # Don't show recent applications in Dock
        show-recents = false;
        tilesize = 50;
        # Don't animate opening applications from the Dock
        launchanim = false;
        # Don't show Dashboard as a Space
        dashboard-in-overlay = true;
        # Don't automatically rearrange Spaces based on most recent use
        mru-spaces = false;
        # Remove the auto-hiding Dock delay
        autohide-delay = 0.0;
        autohide-time-modifier = 0.0;
      };

      finder = {
        # When performing a search, search the current folder by default
        FXDefaultSearchScope = "SCcf";
        # Show all filename extensions
        AppleShowAllFiles = true;
        # Set default finder view to Column View
        FXPreferredViewStyle = "clmv";
      };

      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
      };

      # Firewall
      alf = {
        # Enables Firewall
        globalstate = 1;
        # Enable logging of requests
        loggingenabled = 1;
        # Drops incoming requests via ICMP such as ping requests
        stealthenabled = 1;
      };
    };
  };

  fonts = {
    packages = with pkgs; [
      # Icon fonts
      material-design-icons

      # Nerdfonts
      nerd-fonts.symbols-only
      nerd-fonts.hack
    ];
  };

  homebrew = {
    enable = true;

    taps = [
      "xcodesorg/made"
    ];

    brews = [
      "xcodesorg/made/xcodes"
    ];

    casks = [
      "kitty"
    ];

    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}
