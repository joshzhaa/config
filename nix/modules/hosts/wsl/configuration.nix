{ config, ... }: {
  flake.nixosModules.host-wsl =
    { pkgs, lib, ... }:
    {
      imports = [
        config.flake.nixosModules.headless-packages
        config.flake.nixosModules.terminal-nixos
        config.flake.nixosModules.locale
      ];

      wsl.enable = true;
      wsl.defaultUser = "ssol";

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

      networking.hostName = "wsl";

      users.extraUsers.ssol = {
        shell = pkgs.zsh;
      };

      system.stateVersion = "26.05";
    };
}
