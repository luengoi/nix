{ pkgs, ... }:

{
  imports = [
    ./darwin
  ];

  system.defaults.dock.persistent-apps = [
    "/Applications/Kitty.app"
    "${pkgs.firefox-bin}/Applications/Firefox.app"
    "/System/Applications/Mail.app"
  ];

  homebrew.casks = [
    "proton-pass"
    "protonmail-bridge"
    "zen-browser"
  ];
}
