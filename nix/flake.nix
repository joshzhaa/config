{
  description = "nixos configurations";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, nixos-wsl, ... }:
    let
      system = "x86_64-linux";
      overlay = import ./overlays/kde.nix;
      pkgs = nixpkgs.legacyPackages.${system}.extend overlay;
    in
    {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./laptop/hardware-configuration.nix
            ./laptop/configuration.nix
          ];
        };

        wsl = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            nixos-wsl.nixosModules.default
            ./wsl/configuration.nix
          ];
        };
      };

      # for building on a more powerful machine then `nix copy`ing it.
      # this one typically gets OOMed, so remember --max-jobs.
      packages.${system}.default = pkgs.kdePackages.plasma-workspace;

      formatter.${system} = pkgs.nixfmt-tree;
    };
}
