{ stdenv, ... }:
stdenv.mkDerivation {
  name = "dlvhdr-bins";
  version = "unstable";
  src = ./bin;
  installPhase = ''
    mkdir -p $out/bin
    cp * $out/bin
  '';
}
