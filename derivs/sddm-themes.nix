{ stdenv, fetchFromGitHub, fetchurl } :

{
  sddm-sugar-dark = stdenv.mkDerivation rec {
    pname = "sddm-sugar-dark-theme";
    version = "1.2";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/sugar-dark
    '';

    src = fetchFromGitHub {
      owner = "conixtract";
      repo = "sddm-sugar-dark";
      rev = "658ea7fa8445f5b555aef7ea681ed1cd77c94e48";
      hash = "sha256-Tx+MnBdbLCrMhZhEztd48fGKABJBn/FD5AUxdit+9xY=";
    };
  };
}