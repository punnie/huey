{ pkgs ? import <nixpkgs> {}, hueyGems }:

with pkgs;

stdenv.mkDerivation rec {
  name = "huey";

  src = ./.;

  hueyModules = stdenv.mkDerivation {
    name = "huey-modules";

    inherit src;

    yarnOfflineCache = fetchYarnDeps {
      yarnLock = ./yarn.lock;
      sha256 = "sha256-AZvK/FmTRgFPQYq8WhO4V8TDrkvzDpd0m4QIMromVTI=";
    };

    nativeBuildInputs = [ fixup_yarn_lock nodejs yarn hueyGems hueyGems.wrappedRuby ];

    RAILS_ENV = "production";
    NODE_ENV = "production";

    buildPhase = ''
      export HOME=$PWD

      fixup_yarn_lock $HOME/yarn.lock
      yarn config --offline set yarn-offline-mirror $yarnOfflineCache
      yarn install --offline --frozen-lockfile --ignore-engines --ignore-scripts --no-progress

      patchShebangs $HOME/bin
      patchShebangs $HOME/node_modules

      PATH="$HOME/bin:$PATH" SECRET_KEY_BASE=precompile_placeholder rails assets:precompile
      yarn cache clean --offline
      rm -rf $HOME/node_modules/.cache
    '';

    installPhase = ''
      mkdir -p $out/public
      cp -rv $HOME/public/assets $out/public
    '';
  };

  buildInputs = [ nodejs-slim hueyGems hueyGems.wrappedRuby ];

  buildPhase = ''
    patchShebangs bin/
    cp -rv ${hueyModules}/public/assets public
  '';

  installPhase = ''
    mkdir -p $out/app
    cp -rv * $out/app
  '';
}
