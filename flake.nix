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

        hueyPackage = import ./default.nix { inherit pkgs; };
        dockerImage = import ./docker.nix { inherit pkgs hueyPackage; };
        defaultOverlay = import ./overlay.nix {};
      in {
        packages.huey = hueyPackage;
        packages.docker = dockerImage;
        packages.default = dockerImage;

        devShell = import ./shell.nix { inherit pkgs; };

        overlays.default = (final: prev: {
          huey = hueyPackage;
          huey-docker-image = dockerImage;
        });
      });
}
