{
  lib,
  buildGoModule,
  fetchFromGitHub,
  makeWrapper,
}:
buildGoModule rec {
  pname = "mcd";
  version = "1.1.2";

  src = fetchFromGitHub {
    owner = "omranjamal";
    repo = "mono-cd";
    rev = "v${version}";
    hash = "sha256-yZzD0Jwfn/v4YDOqvNeZmfgHeXiHpPFYZNNKhpSUBNg=";
  };

  vendorHash = "sha256-8R606HaDUXKCMlX34W92Sm1CjSU1OLpFAzJT5sMHhAU=";

  postPatch = ''
    sed 's/1.22.6/1.22.5/' -i go.mod
  '';

  nativeBuildInputs = [ makeWrapper ];

  doCheck = false;

  meta = with lib; {
    description = "Simpler than fzf, more predictable than zoxide, perfect for JavaScript monorepos when cd-ing into monorepo workspace directories.";
    homepage = "https://github.com/omranjamal/mono-cd";
    changelog = "https://github.com/omranjamal/mono-cd/commits";
    maintainers = with maintainers; [ dlvhdr ];
    mainProgram = "mcd";
  };
}
