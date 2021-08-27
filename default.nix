{ mkDerivation, base, hakyll, lib, pandoc }:
mkDerivation {
  pname = "proofconstruction-blog";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base hakyll pandoc ];
  license = "unknown";
  hydraPlatforms = lib.platforms.none;
}
