_: {
  perSystem = { pkgs, ... }: {
    devShells = rec {
      haskell = pkgs.mkShell {
        packages = with pkgs; [
          ghc
          haskell-language-server
          hlint
        ];
      };
      hs = haskell;
    };
  };
}
