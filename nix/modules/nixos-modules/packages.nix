_: {
  flake.nixosModules = {
    headless-packages = { pkgs, ... }: {

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

    };

    desktop-packages = { pkgs, ... }: {

      environment.systemPackages = with pkgs; [
        obsidian
        alacritty
        chromium
      ];

      programs.chromium.enable = true;

    };
  };
}
