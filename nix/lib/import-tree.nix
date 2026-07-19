nixpkgs:
let
  inherit (nixpkgs.lib.fileset) fileFilter toList;
  isNix = file: file.hasExt "nix";
  importTree = path: toList (fileFilter isNix path);
in
importTree
