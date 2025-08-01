{
  rev,
  lib,
  stdenv,
  makeWrapper,
  makeFontsConf,
  brightnessctl,
  app2unit,
  networkmanager,
  grimblast,
  wl-clipboard,
  bluez,
  bash,
  hyprland,
  coreutils,
  findutils,
  file,
  material-symbols,
  nerd-fonts,
  gcc,
  quickshell,
  pipewire,
}: let
  runtimeDeps = [
    brightnessctl
    app2unit
    networkmanager
    grimblast
    wl-clipboard
    bluez
    bash
    hyprland
    coreutils
    findutils
    file
  ];

  fontconfig = makeFontsConf {
    fontDirectories = [material-symbols nerd-fonts.jetbrains-mono];
  };
in
  stdenv.mkDerivation {
    pname = "my-quickshell";
    version = "${rev}";
    src = ./src;

    nativeBuildInputs = [gcc makeWrapper];
    buildInputs = [quickshell pipewire];
    propagatedBuildInputs = runtimeDeps;

    buildPhase = ''
      mkdir -p bin
    '';

    installPhase = ''
      makeWrapper ${quickshell}/bin/qs $out/bin/my-quickshell \
      	--prefix PATH : "${lib.makeBinPath runtimeDeps}" \
      	--set FONTCONFIG_FILE "${fontconfig}" \
      	--add-flags '-p ${./src}'
    '';

    meta = {
      description = "My Quickshell ";
      homepage = "https://github.com/vicnotor/my-quickshell";
      license = lib.licenses.gpl3;
      mainProgram = "my-quickshell";
    };
  }
