{ pkgs ? import <nixpkgs> {}, unstable, hueyGems }:

with pkgs;

mkShell {
    buildInputs = [
        hueyGems
        hueyGems.wrappedRuby
        rubyPackages_3_1.solargraph

        bundix
        overmind

        tailwindcss

        # PostgreSQL from unstable to upgrade pgvector
        (unstable.postgresql_14.withPackages (p: [ p.pgvector ]))
        redis
    ];

    # Export the tailwindcss install dir so the gem can find it
    shellHook = ''
      export TAILWINDCSS_INSTALL_DIR=${tailwindcss}/bin
    '';
}
