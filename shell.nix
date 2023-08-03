{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
    buildInputs = [
        ruby_3_1
        rubyPackages_3_1.solargraph

        bundix
        nodejs
        overmind
        postgresql_14
        redis
        yarn

        nodePackages.eslint
        nodePackages.typescript
        nodePackages.typescript-language-server
    ];
}
