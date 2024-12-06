{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installShellFiles,
  zsh,
  libnotify,
}:

stdenvNoCC.mkDerivation rec {
  pname = "arttime";
  version = "2.3.4";

  src = fetchFromGitHub {
    owner = "poetaman";
    repo = "arttime";
    rev = "v${version}";
    hash = "sha256-hYC9om8141Z+PbJGU4d63Y0Up4kkYslPr3CO5KuwNTc=";
  };

  nativeBuildInputs = [ installShellFiles ];
  buildInputs = [
    zsh
    libnotify
  ];

  dontBuild = true;

  postPatch = ''
    patchShebangs install.sh
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/share/arttime/src
    mkdir -p $out/share/arttime/keypoems
    mkdir -p $out/share/arttime/textart
    mkdir -p $out/share/arttime/doc
    mkdir -p $out/share/man/man1

    ./install.sh --prefix $out --noupdaterc --zcompdir -

    runHook postInstall
  '';

  postInstall = ''
    installManPage share/man/man1/artprint.1.gz share/man/man1/arttime.1.gz
    installShellCompletion --zsh --name _artprint share/zsh/functions/_artprint
    installShellCompletion --zsh --name _arttime share/zsh/functions/_arttime
  '';

  meta = {
    description = "ASCII art with clock/timer/pattern-based time manager in the terminal";
    longDescription = ''
      Beauty of text-art meets functionality of a feature-rich
      clock / timer / pattern-based time manager in terminal. In
      addition to its functional/productivity features, arttime
      brings curated text-art to otherwise artless terminal
      emulators of starving developers and other users who can
      use terminal.
    '';
    homepage = "https://github.com/poetaman/arttime";
    license = with lib.licenses; [
      gpl3Only
      free
    ];
    platforms = lib.platforms.unix;
    maintainers = with lib.maintainers; [ mimvoid ];
  };
}
