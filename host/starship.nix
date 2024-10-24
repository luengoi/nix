{ pkgs, ... }:

{
  imports = [
    ./darwin
  ];

  system.defaults.dock.persistent-apps = [
    "/Applications/Kitty.app"
    "/Applications/Firefox.app"
    "/System/Applications/Mail.app"
  ];
}
