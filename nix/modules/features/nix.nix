{ self, inputs, ... }: {
  flake.nixosModules.nix = _: {
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    nix.registry = {
      nixpkgs.flake = inputs.nixpkgs;
      sys.flake = self;
    };

    nixpkgs.config.allowUnfree = true;
  };
}
