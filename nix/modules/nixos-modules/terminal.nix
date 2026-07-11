_: {
  flake.nixosModules = {
    zsh = _: {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;
      };
    };

    direnv = _: {
      programs.direnv = {
        enable = true;
        enableZshIntegration = true;
      };
    };

    neovim = _: {
      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
      };
    };

    tmux = { pkgs, ... }: {
      programs.tmux = {
        enable = true;
        shortcut = "Space";
        baseIndex = 1;
        historyLimit = 100000;
        keyMode = "vi";
        escapeTime = 0;
        extraConfig = import ./tmux.conf pkgs;
      };
    };
  };
}
