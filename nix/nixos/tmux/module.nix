{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shortcut = "Space";
    baseIndex = 1;
    historyLimit = 100000;
    keyMode = "vi";
    escapeTime = 0;
    extraConfig = import ./tmux.conf pkgs;
  };
}
