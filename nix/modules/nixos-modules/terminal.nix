_: {
  flake.nixosModules = {
    terminal-nixos = { pkgs, ... }: {
      programs = {
        zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestions.enable = true;
          syntaxHighlighting.enable = true;
        };

        direnv = {
          enable = true;
          enableZshIntegration = true;
        };

        neovim = {
          enable = true;
          defaultEditor = true;
          viAlias = true;
        };

        tmux = {
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
  };
}
