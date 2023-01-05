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

            rm -rf log
            ln -s /var/log/huey log
          '';


          installPhase = ''
            mkdir -p $out
            cp -rv $src/* $out
          '';
        };

        dockerImage = pkgs.dockerTools.buildImage {
          name = "huey";
          tag = "latest";
          created = "now";

          config = {
            Cmd = [
              "${hueyPackage}/bin/bundle"
              "exec"
              "puma"
              "-C"
              "${hueyPackage}/config/puma.rb"
              "${hueyPackage}/config.ru"
            ];
            WorkingDir = "/tmp";
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
