{
  self,
  pkgs,
  home,
  ...
}:
let
  plasmoid_kvitals = pkgs.stdenvNoCC.mkDerivation (finalAttrs: {
    name = "KVitals";
    pname = "plasmoid_kvitals";
    version = "v2.10.1";

    src = pkgs.fetchFromGitHub {
      owner = "yassine20011";
      repo = "kvitals";
      rev = "v2.10.1";
      sha256 = "sha256-fOruZ4UwLL29aK3Yida1Ky+BQBk/gqR8Mg2mB3muFpc=";
    };

    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/plasma/plasmoids/org.kde.plasma.kvitals
      cp -r ./* $out/share/plasma/plasmoids/org.kde.plasma.kvitals
      runHook postInstall
    '';
  });
in
{
  home.file.".local/share/plasma/plasmoids/org.kde.plasma.kvitals" = {
    source = "${plasmoid_kvitals}/share/plasma/plasmoids/org.kde.plasma.kvitals";
  };
}
