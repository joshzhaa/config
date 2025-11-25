# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "ssol";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    git
    ripgrep
    fd
    tree-sitter
    starship
    nil
    statix
  ];

  users.extraUsers.ssol = {
    shell = pkgs.zsh;
  };

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
    };

    starship.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      enableLsColors = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };

    tmux = {
      enable = true;
      shortcut = "Space";
      baseIndex = 1;
      historyLimit = 100000;
      keyMode = "vi";
      escapeTime = 0;
      plugins = with pkgs; [
        tmuxPlugins.catppuccin
      ];
      # check $TERM
      extraConfig = ''
        set -g mouse on
        set -g default-shell /run/current-system/sw/bin/zsh
        set -g default-terminal "screen-256color"
        set -sa terminal-overrides "xterm-256color:RGB"
        set -g status-position top

        bind-key h select-pane -L
        bind-key j select-pane -D
        bind-key k select-pane -U
        bind-key l select-pane -R

        bind-key -T copy-mode-vi 'v' send -X begin-selection
        bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
      '';
    };
  };
}
