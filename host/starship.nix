{ ... }:

{
  imports = [
    ./darwin
  ];

  system.defaults.dock.persistent-apps = [
    "/Applications/Kitty.app"
    "/Applications/Zen.app"
    "/System/Applications/Mail.app"
  ];

  homebrew.casks = [
    "proton-pass"
    "protonmail-bridge"
    "zen-browser"
  ];
}
