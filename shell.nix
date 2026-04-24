{ pkgs ? import <nixpkgs> {} }:

let
  nixglhostSrc = builtins.fetchTarball {
    url = "https://github.com/numtide/nix-gl-host/archive/refs/heads/main.tar.gz";
  };
  nixglhost = import nixglhostSrc { inherit pkgs; };
in

pkgs.mkShell {
  buildInputs = with pkgs; [
    pkgs.stdenv.cc.cc.lib     # provides libstdc++.so.6
    nixglhost                 # bind to system driver (but ManimCE is CPU bound)

    python3
    uv

    pkg-config                # manim dependencies
    ffmpeg
    cairo
    pango
    glib
    pixman
    fontconfig
    freetype
    harfbuzz
    texliveFull
    dejavu_fonts

  ];


  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
    export PKG_CONFIG_PATH=${pkgs.cairo.dev}/lib/pkgconfig:${pkgs.pango.dev}/lib/pkgconfig:${pkgs.fontconfig.dev}/lib/pkgconfig
    export FONTCONFIG_FILE=${pkgs.fontconfig.out}/etc/fonts/fonts.conf

    echo "Python and uv are ready!"
    python --version
    uv --version

    # enable nvidia GPU on homelab
    export __NV_PRIME_RENDER_OFFLOAD=1 
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export UV_CACHE_DIR=/home/yves/DEV/.uv_cache

    if [ ! -d .venv ]; then
      uv venv
    fi
    source .venv/bin/activate
    echo "uv virtualenv activated"
  '';
}
