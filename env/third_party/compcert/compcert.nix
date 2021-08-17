with import <nixpkgs> {};

stdenv.mkDerivation {
	name = "ccomp-";
	buildInputs = []
	++ (with coqPackages_8_13; [ coq ssreflect ])
	;
}
