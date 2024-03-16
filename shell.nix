{ pkgs ? import <nixpkgs> {}, hueyGems }:

with pkgs;

mkShell {
    buildInputs = [
        hueyGems
        hueyGems.wrappedRuby
        rubyPackages_3_1.solargraph

        imagemagick

        bundix
        overmind

        tailwindcss

        # For Github Copilot
        nodejs

        # PostgreSQL from unstable to upgrade pgvector
        (postgresql_15.withPackages (p: [ p.pgvector ]))
        redis
    ];

    # Export the tailwindcss install dir so the gem can find it
    shellHook = ''
      export TAILWINDCSS_INSTALL_DIR=${tailwindcss}/bin
    '';
}
