{ self, inputs, ... }:
let
  inherit (inputs) nixos-wsl nixpkgs;
in
{
  flake.nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.host-laptop
      self.nixosModules.host-laptop-hardware
    ];
  };

  flake.nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
    modules = [
      nixos-wsl.nixosModules.default
      self.nixosModules.host-wsl
    ];
  };
}
