{ pkgs }:


let
  imgLink = "https://github.com/2sleepy4u/machines/blob/f8ec8f79954792aeabbeebb6f7991434e0681fd7/eva02.png?raw=true";

  image = pkgs.fetchurl {
    url = imgLink;
    sha256 = "sha256-r5Q7kWf0cii2bvMFg9drJmHlchdvYWlz03+3NrlUVNI=";
  };
in
pkgs.stdenv.mkDerivation {
  name = "sugar-dark";
  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-sugar-dark";
    rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
    cd $out/
    rm Background.jpg
    cp -r ${image} $out/Background.jpg
   '';
}
