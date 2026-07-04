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
    # tui
    neovim
    tree-sitter
  ];
}
