{
  lib,
  stdenvNoCC,
  fetchurl,
  unzip,
}:

stdenvNoCC.mkDerivation {
  pname = "gugi-font";
  version = "1.001";

  src = fetchurl {
    url = "https://www.1001fonts.com/download/gugi.zip";
    sha256 = "03fi13rbf6cflxh3szrwzplij14vynwrydinc2r3bpj78wlpz2f5";
  };

  nativeBuildInputs = [ unzip ];

  # src is a plain zip of ttf + license; unpack it ourselves
  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/fonts/truetype
    unzip -j $src '*.ttf' -d $out/share/fonts/truetype
    runHook postInstall
  '';

  meta = with lib; {
    description = "Gugi typeface (OFL), as distributed by 1001fonts";
    homepage = "https://www.1001fonts.com/gugi-font.html";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
