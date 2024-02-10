{
  description = "Huey flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        unstable = import nixpkgs-unstable { inherit system; };

        ruby = pkgs.ruby_3_1;

        hueyGems = pkgs.bundlerEnv {
          name = "huey-bundler-env";
          inherit ruby;
          gemfile  = ./Gemfile;
          lockfile = ./Gemfile.lock;
          gemset   = ./gemset.nix;
        };

        hueyPackage = import ./default.nix { inherit pkgs hueyGems; };
      in {
        # Packages
        packages.huey = hueyPackage;
        packages.default = hueyPackage;

        # Development shells
        devShell = import ./shell.nix { inherit pkgs unstable hueyGems; };

        # Overlays
        overlays.default = (final: prev: {
          huey = hueyPackage;
        });
      });
}
