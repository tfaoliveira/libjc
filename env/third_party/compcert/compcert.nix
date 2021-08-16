with import <nixpkgs> {};

stdenv.mkDerivation {
	name = "ccomp-v3.6";
	buildInputs = []
	++ (with coqPackages_8_9; [ coq ssreflect ])
	;
}
