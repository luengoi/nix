{
  description = "Flake to configure various macOS and linux systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # nix-darwin provides a system configuration layer for macOS that's
    # simialr to what's provided in NixOS
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix User Repository
    nur.url = "github:nix-community/nur";

    # Firefox overlay for macOS
    firefox-darwin.url = "github:luengoi/nix-firefox-darwin";
  };

  outputs =
    inputs@{ darwin, ... }:
    let
      mkDarwinConfiguration = import ./lib/mkDarwinConfiguration.nix;
    in
    {
      darwinConfigurations = {
        starship = mkDarwinConfiguration {
          inherit darwin inputs;

          target = {
            host.system = "aarch64-darwin";
            host.config = ./host/starship.nix;
            host.stateVersion = 5;
            user.name = "iluengo";
            user.home = "/Users/iluengo";
            home.config = "starship.nix";
            home.stateVersion = "24.11";
          };
        };
      };
    };
}
