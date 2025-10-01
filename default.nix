{
  rev,
  lib,
  stdenv,
  makeWrapper,
  quickshell,
}:
stdenv.mkDerivation {
  pname = "my-quickshell";
  version = "${rev}";
  src = ./src;

  nativeBuildInputs = [makeWrapper];
  buildInputs = [quickshell];

  buildPhase = ''
    mkdir -p bin
  '';

  installPhase = ''
    makeWrapper ${quickshell}/bin/qs $out/bin/my-quickshell \
    	--add-flags '-p ${./src}'
  '';

  meta = {
    description = "My Quickshell ";
    homepage = "https://github.com/vicnotor/my-quickshell";
    license = lib.licenses.gpl3;
    mainProgram = "my-quickshell";
  };
}
