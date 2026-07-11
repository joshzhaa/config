# overlay trick adapted from mbleichner in https://github.com/NixOS/nixpkgs/issues/126590
pkgs-final: pkgs-prev:
let
  plasma-workspace-prev = pkgs-prev.kdePackages.plasma-workspace;

  xdg-data = pkgs-prev.stdenv.mkDerivation {
    name = "xdg-data";
    buildInputs = [ plasma-workspace-prev ];
    dontUnpack = true;
    dontFixup = true;
    dontWrapQtApps = true;
    installPhase = ''
      mkdir -p $out/share
      ( IFS=:
        for DIR in $XDG_DATA_DIRS; do
          if [[ -d "$DIR" ]]; then
            cp -r $DIR/. $out/share/
            chmod -R u+w $out/share
          fi
        done
      )
    '';
  };
in
{
  kdePackages = pkgs-prev.kdePackages // {
    plasma-workspace = plasma-workspace-prev.overrideAttrs {
      preFixup = ''
        for index in "''${!qtWrapperArgs[@]}"; do
          if [[ ''${qtWrapperArgs[$((index+0))]} == "--prefix" ]] && [[ ''${qtWrapperArgs[$((index+1))]} == "XDG_DATA_DIRS" ]]; then
            unset -v "qtWrapperArgs[$((index+0))]"
            unset -v "qtWrapperArgs[$((index+1))]"
            unset -v "qtWrapperArgs[$((index+2))]"
            unset -v "qtWrapperArgs[$((index+3))]"
          fi
        done
        qtWrapperArgs=("''${qtWrapperArgs[@]}")
        qtWrapperArgs+=(--prefix XDG_DATA_DIRS : "${xdg-data}/share")
        qtWrapperArgs+=(--prefix XDG_DATA_DIRS : "$out/share")
      '';
    };
  };
}
