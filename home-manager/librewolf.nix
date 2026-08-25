{pkgs, ...}: {
  programs.librewolf = {
    enable = true;
    profiles.default = {
      id = 0;
      isDefault = true;
      # ==============================
      # Search Engine Configuration
      # ==============================
      search = {
        force = true;
        default = "google";
        engines = {
          "google" = {
            name = "Google";
            urls = [
              {
                template = "https://www.google.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [
              "@g"
            ];
            icon = "https://www.google.com/favicon.ico";
          };
        };
      };
      # Browser Preferences
      settings = {
        # Homepage
        "browser.startup.page" = 1;
        "browser.startup.homepage" = "https://www.google.com";
        # Search suggestions
        "browser.search.suggest.enabled" = true;
        "browser.urlbar.suggest.searches" = true;
        # Use the same search engine in private windows
        "browser.search.separatePrivateDefault" = false;
        # Dark Theme
        "layout.css.prefers-color-scheme.content-override" = 0;
        "ui.systemUsesDarkTheme" = 1;
        # Enable custom CSS
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        # ==========================
        # DNS over HTTPS
        # Cloudflare
        # ==========================
        "network.trr.mode" = 3;
        "network.trr.uri" = "https://mozilla.cloudflare-dns.com/dns-query";

        "network.trr.bootstrapAddress" = "1.1.1.1";
        # Privacy
        "extensions.pocket.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "app.shield.optoutstudies.enabled" = false;
        # Disable sponsored suggestions
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        # UI
        "browser.tabs.closeWindowWithLastTab" = false;
        "browser.uidensity" = 1;
        # History
        "privacy.sanitize.sanitizeOnShutdown" = true;
        "privacy.clearOnShutdown.history" = true;
        "privacy.clearOnShutdown.downloads" = true;
        "privacy.clearOnShutdown.cookies" = true;
        "privacy.clearOnShutdown.sessions" = true;
        "privacy.clearOnShutdown.cache" = true;
        "privacy.clearOnShutdown.formdata" = true;
      };
      # ==============================
      # Extensions
      # ==============================
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        # Add extensions available in NUR here
        # Example:
        # ublock-origin
        # bitwarden
        # darkreader
      ];
    };
  };
}
