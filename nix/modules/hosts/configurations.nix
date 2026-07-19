{ config, inputs, ... }:
let
  inherit (inputs) nixos-wsl nixpkgs;
in
{
  flake.nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
    modules = [
      config.flake.nixosModules.host-laptop
      config.flake.nixosModules.host-laptop-hardware
    ];
  };

  flake.nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
    modules = [
      nixos-wsl.nixosModules.default
      config.flake.nixosModules.host-wsl
    ];
  };
}
