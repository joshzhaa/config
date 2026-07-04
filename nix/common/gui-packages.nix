{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    obsidian
    alacritty
    chromium
  ];

  programs.chromium.enable = true;
}
