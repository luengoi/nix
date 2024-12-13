{
  darwin,
  inputs,
  target,
  ...
}:

darwin.lib.darwinSystem {
  system = target.host.system;
  specialArgs = { inherit inputs target; };
  modules = [
    {
      nixpkgs.overlays = with inputs; [
        nur.overlays.default
        firefox-darwin.overlay
      ];
      nixpkgs.config = {
        allowUnfree = true;
      };
    }
    target.host.config

    inputs.home-manager.darwinModules.home-manager
    {
      users.users."${target.user.name}".home = target.user.home;
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        extraSpecialArgs = { inherit target; };
        users."${target.user.name}" = import ../home/${target.home.config};
      };
    }
  ];
}
