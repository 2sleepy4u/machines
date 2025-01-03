with import <nixpkgs> {};
with pkgs.python3Packages;

buildPythonPackage {
  name = "skeep";
  src = pkgs.fetchFromGitHub {
	  owner = "2sleepy4u";
	  rev = "main";
	  repo = "keep-or-skip";
	  sha256 = "sha256-0KgpZIsuqDjPqg64cmKnuWh8p3Te13MZsiu86CVVEXI="; # TODO
  };
  propagatedBuildInputs = [ pygame ];
}
