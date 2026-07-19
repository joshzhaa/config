{ config, ... }: {
  flake.nixosModules.host-laptop =
    { pkgs, ... }:
    {
      imports = [
        config.flake.nixosModules.headless-packages
        config.flake.nixosModules.desktop-packages
        config.flake.nixosModules.terminal-nixos
        config.flake.nixosModules.locale
        config.flake.nixosModules.sound
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      nixpkgs.config.allowUnfree = true;
      nixpkgs.overlays = [ config.flake.overlays.kde ];

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

      programs.chromium.enable = true;

      fonts.packages = [ pkgs.nerd-fonts.hack ];

      system.stateVersion = "26.05";
    };
}
