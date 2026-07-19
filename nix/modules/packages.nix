{ self, inputs, ... }: {
  perSystem = { pkgs, system, ... }: {
    # for building on a more powerful machine, then `nix copy`ing it.
    # this one often gets OOMed, so remember --max-jobs.
    packages.plasma-final = pkgs.kdePackages.plasma-workspace;
    packages.plasma-prev = inputs.nixpkgs.legacyPackages.${system}.kdePackages.plasma-workspace;

    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [ self.overlays.kde ];
      config.allowUnfree = true;
    };
  };
}
