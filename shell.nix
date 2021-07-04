with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "blog-env";
  buildInputs = [
    haskellPackages.hakyll
    zlib
    haskellPackages.zlib
    cabal-install
    ghc
    glibcLocales
  ];
}
