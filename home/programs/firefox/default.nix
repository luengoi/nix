{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DontCheckDefaultBrowser = true;
      DisablePocket = true;
      SearchBar = "unified";

      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;
    };

    profiles.default = {
      id = 0;

      search = {
        force = true;
        default = "DuckDuckGo";
        order = [
          "DuckDuckGo"
          "Google"
        ];
        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "GitHub" = {
            urls = [
              {
                template = "https://github.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "https://github.com/favicon.ico";
            definedAliases = [ "@gh" ];
          };
          "YouTube" = {
            urls = [
              {
                template = "https://www.youtube.com/results";
                params = [
                  {
                    name = "search_query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "https://www.youtube.com/favicon.ico";
            definedAliases = [ "@yt" ];
          };
          "Google Images" = {
            urls = [
              {
                template = "https://www.google.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                  {
                    name = "udm";
                    value = "2";
                  }
                ];
              }
            ];
            icon = "https://www.google.com/favicon.ico";
            definedAliases = [ "@yt" ];
          };
          "Bing".metaData.hidden = true;
          "Google".metaData.alias = "@g";
        };
      };

      settings = {
        "signon.rememberSignons" = false;
        "browser.compactmode.show" = true;
        "browser.cache.disk.enable" = false;
        "places.history.enabled" = false;
        "privacy.history.custom" = true;
        "privacy.sanitize.sanitizeOnShutdown" = true;
        "privacy.sanitize.clearOnShutdown.hasMigratedToNewPrefs2" = true;
        "extensions.pocket.enabled" = false;
        "browser.topsites.contile.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.system.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.newtabWallpapers.wallpaper" = "dark-color";
        "browser.newtabpage.activity-stream.newtabWallpapers.wallpaper-dark" = "dark-color";
        "browser.newtabpage.activity-stream.newtabWallpapers.wallpaper-light" = "dark-color";
        "browser.formfill.enable" = false;
        "browser.search.suggest.enabled" = false;
        "browser.search.suggest.enabled.private" = false;
        "browser.urlbar.suggest.searches" = false;
        "browser.urlbar.showSearchSuggestionsFirst" = false;
        "app.shield.optoutstudies.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
      };

      containersForce = true;
      containers = {
        Personal = {
          color = "blue";
          icon = "fingerprint";
          id = 0;
        };
        Work = {
          color = "orange";
          icon = "briefcase";
          id = 1;
        };
        Shopping = {
          color = "pink";
          icon = "cart";
          id = 2;
        };
        Research = {
          color = "turquoise";
          icon = "chill";
          id = 3;
        };
      };

      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        darkreader
        multi-account-containers
        foxyproxy-standard
        privacy-badger
      ];
    };
  };
}
