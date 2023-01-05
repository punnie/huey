{
  description = "Huey";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        ruby = pkgs.ruby;
        solargraph = pkgs.rubyPackages.solargraph;

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

          buildInputs = [ pkgs.bash hueyGems hueyGems.wrappedRuby ];

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
          };
        };

        hueyDevShell = pkgs.mkShell {
          buildInputs = [ pkgs.bash hueyGems hueyGems.wrappedRuby solargraph ];
        };

      in {
        packages = {
          huey = hueyPackage;
          docker = dockerImage;
        };
        packages.default = dockerImage;

        devShells.huey = hueyDevShell;
        devShells.default = hueyDevShell;
      });
}
