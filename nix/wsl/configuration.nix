{ pkgs, ... }:
{
  imports = [
    ../common/packages.nix
    ../nixos/tmux/module.nix
    ../nixos/zsh.nix
    ../nixos/direnv.nix
    ../nixos/neovim.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "ssol";

  users.extraUsers.ssol = {
    shell = pkgs.zsh;
  };

  system.stateVersion = "26.05";
}
