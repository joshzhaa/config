{ self, ... }: {
  flake.nixosModules.host-wsl =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.headless-packages
        self.nixosModules.locale
        self.nixosModules.zsh
        self.nixosModules.direnv
        self.nixosModules.neovim
        self.nixosModules.tmux
      ];

      wsl.enable = true;
      wsl.defaultUser = "ssol";

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      networking.hostName = "wsl";

      users.extraUsers.ssol = {
        shell = pkgs.zsh;
      };

      system.stateVersion = "26.05";
    };
}
