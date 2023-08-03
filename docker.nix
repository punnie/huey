{ pkgs ? import <nixpkgs> {}, hueyPackage }:

with pkgs;

dockerTools.buildImage {
  name = "huey";
  tag = "latest";
  created = "now";

  copyToRoot = hueyPackage;

  config = {
    WorkingDir = "/app";
    Volumes = { "/tmp" = { }; };
    Env = [ "SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt" ];
  };
}
