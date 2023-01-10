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

        hueyPackage = pkgs.stdenv.mkDerivation {
          name = "huey";

          src = self;

          buildInputs = [ pkgs.cacert hueyGems hueyGems.wrappedRuby ];

          buildPhase = ''
            patchShebangs bin/
          '';

          installPhase = ''
            mkdir -p $out/app
            cp -rv $src/* $out/app
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
