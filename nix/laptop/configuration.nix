# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common/locale.nix
    ../common/packages.nix
    ../nixos/tmux/module.nix
    ../nixos/zsh.nix
    ../nixos/direnv.nix
    ../nixos/neovim.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ (import ../overlays/kde.nix) ];

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

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  # PulseAudio and PipeWire use this
  security.rtkit.enable = true;

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

  programs.chromium.enable = true;

  system.stateVersion = "26.05"; # Did you read the comment?
}
