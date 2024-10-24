{ darwin, inputs, target, ... }:

darwin.lib.darwinSystem {
  system = target.host.system;
  specialArgs = { inherit inputs target; };
  modules = [
    { nixpkgs.overlays = with inputs; [ nur.overlay ]; }
    target.host.config

    inputs.nix-homebrew.darwinModules.nix-homebrew
    {
      nix-homebrew = {
        # Install homebrew under the default prefix
        enable = true;
        user = target.user.name;

        # Homebrew taps
        taps = {
          "xcodesorg/made" = inputs.xcodesorg;
        };
      };
    }

    inputs.home-manager.darwinModules.home-manager
    {
      users.users."${target.user.name}".home = target.user.home;
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit target; };
        users."${target.user.name}" = import ../home/${target.home.config};
      };
    }
  ];
}
