{ lib, stdenv, fetchurl, autoPatchelfHook }:

# gogcli — "Google Workspace in your terminal" (binary is `gog`).
# Upstream ships prebuilt release binaries; we wrap those instead of building
# from source (no Go compile — kind to a low-RAM machine) and instead of using
# the nixpkgs package, which lags well behind (0.11 vs upstream 0.21).
#
# To update: bump `version`, then refresh the four hashes. Get them from
#   https://github.com/openclaw/gogcli/releases/download/v<version>/checksums.txt
# and convert each with: nix hash convert --hash-algo sha256 --to sri <hex>
let
  version = "0.21.0";

  plat = {
    x86_64-linux = "linux_amd64";
    aarch64-linux = "linux_arm64";
    x86_64-darwin = "darwin_amd64";
    aarch64-darwin = "darwin_arm64";
  }.${stdenv.hostPlatform.system}
    or (throw "gogcli: unsupported system ${stdenv.hostPlatform.system}");

  hash = {
    linux_amd64 = "sha256-YTHz7iOusU4LhoyO8tLy1rFY6DQVXm9GMeJ5HPOssic=";
    linux_arm64 = "sha256-GVa2zEefKNJbwelVyFau7USwXJUEaE0T2Rg3rCAnZw4=";
    darwin_amd64 = "sha256-+hptmzKZJH2HdAdMbNKqNkP/bkhk2KMlo5NUVt0dkx4=";
    darwin_arm64 = "sha256-59/cIsM+lFSJCJAm8B80+36VT+OnQIHH7mdRxpr3KSk=";
  }.${plat};
in
stdenv.mkDerivation {
  pname = "gogcli";
  inherit version;

  src = fetchurl {
    url = "https://github.com/openclaw/gogcli/releases/download/v${version}/gogcli_${version}_${plat}.tar.gz";
    inherit hash;
  };

  sourceRoot = ".";

  # Go binaries on Linux still need their interpreter patched to the nix loader.
  nativeBuildInputs = lib.optionals stdenv.isLinux [ autoPatchelfHook ];

  installPhase = ''
    runHook preInstall
    install -Dm755 gog $out/bin/gog
    runHook postInstall
  '';

  meta = {
    description = "Google Workspace in your terminal";
    homepage = "https://github.com/openclaw/gogcli";
    license = lib.licenses.mit;
    mainProgram = "gog";
    platforms = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
  };
}
