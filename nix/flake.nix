{
  description = "nixos configurations";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    nixos-wsl.url = "github:nix-community/nixos-wsl";
  };

  outputs =
    { nixpkgs, nixos-wsl, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
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

      formatter.${system} = pkgs.nixfmt-tree;
    };
}
