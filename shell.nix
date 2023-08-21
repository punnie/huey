{ pkgs ? import <nixpkgs> {}, hueyGems }:

with pkgs;

mkShell {
    buildInputs = [
        hueyGems
        hueyGems.wrappedRuby
        rubyPackages_3_1.solargraph

        bundix
        nodejs
        overmind
        (postgresql_14.withPackages (p: [ p.pgvector ]))
        redis
        yarn

        nodePackages.eslint
        nodePackages.typescript
        nodePackages.typescript-language-server
    ];
}
