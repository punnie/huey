{ pkgs ? import <nixpkgs> {}, unstable, hueyGems }:

with pkgs;

mkShell {
    buildInputs = [
        hueyGems
        hueyGems.wrappedRuby
        rubyPackages_3_1.solargraph

        bundix
        nodejs
        overmind
        yarn

        # PostgreSQL from unstable to upgrade pgvector
        (unstable.postgresql_14.withPackages (p: [ p.pgvector ]))
        redis

        nodePackages.eslint
        nodePackages.typescript
        nodePackages.typescript-language-server
    ];
}
