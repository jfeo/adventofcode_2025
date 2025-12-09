with import <nixpkgs> { };

stdenv.mkDerivation {
  name = "ruby";
  nativeBuildInputs = [
    ruby
    rubyPackages.solargraph
    rubocop
  ];
  buildInputs = [ ];
  shellHook = "";
}
