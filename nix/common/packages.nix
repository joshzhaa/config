{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # nix
    nil
    nixd
    statix
    nh
    # cli
    git
    ripgrep
    fd
    starship
    # gui
    obsidian
    alacritty
    # tui
    neovim
    tree-sitter
  ];
}
