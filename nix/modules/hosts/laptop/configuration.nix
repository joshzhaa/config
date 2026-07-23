{ config, inputs, ... }: {

  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      config.flake.nixosModules.host-laptop
      config.flake.nixosModules.host-laptop-hardware
    ];
  };

  flake.nixosModules.host-laptop =
    { pkgs, ... }:
    {
      imports = with config.flake.nixosModules; [
        headless-packages
        desktop-packages
        terminal-nixos
        locale
        sound
        nix
      ];

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
        displayManager.plasma-login-manager.enable = true;
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
