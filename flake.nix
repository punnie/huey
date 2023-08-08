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

        hueyGems = pkgs.bundlerEnv {
          name = "huey-bundler-env";
          inherit ruby;
          gemfile  = ./Gemfile;
          lockfile = ./Gemfile.lock;
          gemset   = ./gemset.nix;
        };

        hueyPackage = import ./default.nix { inherit pkgs hueyGems; };
        dockerImage = import ./docker.nix { inherit pkgs hueyPackage; };
      in {
        # Packages
        packages.huey = hueyPackage;
        packages.docker = dockerImage;
        packages.default = dockerImage;

        # Development shells
        devShell = import ./shell.nix { inherit pkgs hueyGems; };

        # Overlays
        overlays.default = (final: prev: {
          huey = hueyPackage;
          huey-docker-image = dockerImage;
        });
      });
}
