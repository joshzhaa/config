_: {
  flake.nixosModules = {
    headless-packages = { pkgs, ... }: {

      environment.systemPackages = with pkgs; [
        # nix
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

      environment.variables = {
        NH_FLAKE = "$HOME/config/nix";
      };

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
