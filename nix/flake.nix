{
  description = "nixos configurations";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      inherit (inputs)
        self
        flake-parts
        nixpkgs
        treefmt-nix
        ;
      importTree = import ./lib/import-tree.nix nixpkgs;
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = importTree ./modules ++ [ treefmt-nix.flakeModule ];
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      perSystem = { pkgs, system, ... }: {
        # for building on a more powerful machine, then `nix copy`ing it.
        # this one often gets OOMed, so remember --max-jobs.
        packages.plasma-final = pkgs.kdePackages.plasma-workspace;
        packages.plasma-prev = nixpkgs.legacyPackages.${system}.kdePackages.plasma-workspace;

        _module.args.pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlays.kde ];
          config.allowUnfree = true;
        };
      };
    };
}
