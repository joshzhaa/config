{ config, inputs, ... }: {

  flake.nixosConfigurations.wsl = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.nixos-wsl.nixosModules.default
      config.flake.nixosModules.host-wsl
    ];
  };

  flake.nixosModules.host-wsl =
    { pkgs, ... }:
    {
      imports = with config.flake.nixosModules; [
        headless-packages
        terminal-nixos
        locale
        nix
      ];

      wsl.enable = true;
      wsl.defaultUser = "ssol";

      # TODO: determine if this line actually does something
      # nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

      networking.hostName = "wsl";

      users.extraUsers.ssol = {
        shell = pkgs.zsh;
      };

      system.stateVersion = "26.05";
    };
}
