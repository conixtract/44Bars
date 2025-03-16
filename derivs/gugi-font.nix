{ lib, stdenv } : 

stdenv.mkDerivation {
    name = "gugi-font";

    src = "/home/pk/Downloads/gugi.zip";

    dontBuild = true;
    installPhase = ''
        mkdir -p $out/share/fonts/gugi
        unzip -j $src -d $out/share/fonts/gugi
    '';
}