{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;

    profiles.default = {
      id = 0;

      search = {
        force = true;
        default = "DuckDuckGo";
        order = [ "DuckDuckGo" "Google" ];
        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  { name = "type"; value = "packages"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }
            ];
            icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "Bing".metaData.hidden = true;
          "Google".metaData.alias = "@g";
        };
      };

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        darkreader
        multi-account-containers
        foxyproxy-standard
      ];
    };
  };
}
