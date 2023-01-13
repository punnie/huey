{
  description = "Huey flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        ruby = pkgs.ruby_3_1;
        solargraph = pkgs.rubyPackages_3_1.solargraph;

        hueyGems = pkgs.bundlerEnv {
          name = "huey-bundler-env";
          inherit ruby;
          gemfile  = ./Gemfile;
          lockfile = ./Gemfile.lock;
          gemset   = ./gemset.nix;
        };

        hueyPackage = pkgs.stdenv.mkDerivation rec {
          name = "huey";

          src = self;

          hueyModules = pkgs.stdenv.mkDerivation {
            name = "huey-modules";

            inherit src;

            yarnOfflineCache = pkgs.fetchYarnDeps {
              yarnLock = ./yarn.lock;
              sha256 = "sha256-oQMVZK0v8qyxCGrCo3cMAPWECFnE1IkjMBP4h+zsPYg=";
            };

            nativeBuildInputs = [ (with pkgs; [ fixup_yarn_lock nodejs yarn ]) hueyGems hueyGems.wrappedRuby ];

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

          buildInputs = [ pkgs.cacert pkgs.nodejs-slim hueyGems hueyGems.wrappedRuby ];

          buildPhase = ''
            patchShebangs bin/
            cp -rv ${hueyModules}/public/assets public
          '';

          installPhase = ''
            mkdir -p $out/app
            cp -rv * $out/app
          '';
        };

        dockerImage = pkgs.dockerTools.buildImage {
          name = "huey";
          tag = "latest";
          created = "now";

          copyToRoot = hueyPackage;

          config = {
            WorkingDir = "/app";
            Volumes = { "/tmp" = { }; };
            Env = [ "SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt" ];
          };
        };

        hueyDevShell = pkgs.mkShell {
          buildInputs = [
            hueyGems
            hueyGems.wrappedRuby
            solargraph

            (with pkgs; [
              bundix
              nodejs
              yarn
            ])

            (with pkgs.nodePackages; [
              eslint
              typescript
              typescript-language-server
            ])
          ];
        };

      in {
        packages = {
          huey = hueyPackage;
          docker = dockerImage;
        };
        packages.default = dockerImage;

        devShells.huey = hueyDevShell;
        devShells.default = hueyDevShell;

        overlays.default = (final: prev: {
          huey = hueyPackage;
          huey-docker-image = dockerImage;
        });
      });
}
