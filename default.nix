{ pkgs ? import <nixpkgs> {}, hueyGems }:

with pkgs;

stdenv.mkDerivation rec {
  name = "huey";

  src = ./.;

  buildInputs = [ hueyGems hueyGems.wrappedRuby tailwindcss ];

  buildPhase = ''
    # Patch shebangs
    patchShebangs bin/

    # Precompile assets
    export TAILWINDCSS_INSTALL_DIR=${tailwindcss}/bin
    export SECRET_KEY_BASE=precompile_placeholder 

    rails assets:precompile
    rails tmp:clear
  '';

  installPhase = ''
    # Copy the app to the output directory
    mkdir -p $out/app
    cp -rv * $out/app
  '';
}
