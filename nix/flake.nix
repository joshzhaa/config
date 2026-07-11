{
  description = "nixos configurations";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      inherit (inputs) self flake-parts nixpkgs;
      mkFlake = flake-parts.lib.mkFlake { inherit inputs; };
    in
    mkFlake {
      imports = [
        ./modules/hosts/configurations.nix
        ./modules/hosts/laptop/configuration.nix
        ./modules/hosts/laptop/hardware-configuration.nix
        ./modules/hosts/laptop/sound.nix
        ./modules/hosts/wsl/configuration.nix
        ./modules/nixos-modules/locale.nix
        ./modules/nixos-modules/packages.nix
        ./modules/nixos-modules/terminal.nix
        ./modules/overlays/module.nix
      ];
      systems = [ "x86_64-linux" ];

      perSystem = { pkgs, system, ... }: {
        # for building on a more powerful machine, then `nix copy`ing it.
        # this one often gets OOMed, so remember --max-jobs.
        packages.default = pkgs.kdePackages.plasma-workspace;

        formatter = pkgs.nixfmt-tree;

        _module.args.pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlays.kde ];
          config.allowUnfree = true;
        };
      };
    };
}
