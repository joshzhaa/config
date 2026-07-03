{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # nix
    nil
    nixd
    statix
    nixfmt
    nh
    # cli
    git
    ripgrep
    fd
    starship
    # gui
    obsidian
    alacritty
    chromium
    # tui
    neovim
    tree-sitter
  ];
}
