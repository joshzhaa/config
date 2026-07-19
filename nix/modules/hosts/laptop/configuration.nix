{ self, ... }: {
  flake.nixosModules.host-laptop =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.headless-packages
        self.nixosModules.desktop-packages
        self.nixosModules.locale
        self.nixosModules.zsh
        self.nixosModules.direnv
        self.nixosModules.neovim
        self.nixosModules.tmux
        self.nixosModules.sound
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      nixpkgs.config.allowUnfree = true;
      nixpkgs.overlays = [ self.overlays.kde ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking = {
        hostName = "laptop";
        networkmanager.enable = true;
        nameservers = [ "1.1.1.1" ];
      };

      services = {
        # Enable the KDE Plasma Desktop Environment.
        displayManager.sddm.enable = true;
        desktopManager.plasma6.enable = true;

        system76-scheduler.enable = true;

        # Enable CUPS to print documents.
        printing.enable = true;
      };

      # Define a user account.
      users.users."ssol" = {
        isNormalUser = true;
        description = "ssol";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        shell = pkgs.zsh;
      };

      fonts.packages = [ pkgs.nerd-fonts.hack ];

      system.stateVersion = "26.05";
    };
}
