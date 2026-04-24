# Fully working [Manim setup ⮺](https://docs.manim.community/en/stable/installation/uv.html)

**Note** that ManimCE is CPU based, and that's what is configured here,
Binding with system GPU is provided but not usefull here

- [nix](https://yduf.github.io/package-nix/) provides standard tools python + uv
- [uv](https://docs.astral.sh/uv/) manage python packages 
- thanks to [NixGLHost](https://github.com/numtide/nix-gl-host?tab=readme-ov-file#nixglhost---nix-openglcuda-wrapper) we can bridge  [system driver](https://yduf.github.io/pc-hardware-gpu-rtx-5070Ti/#linux-setup) to nix setup

<pre>
.
├── pyproject.toml
└── shell.nix
</pre>


## Setup

As a prerequesite, you need to have
- [nix](https://yduf.github.io/package-nix/) package manager installed. 

```bash
# This is the regular call to have a working environment
# use nix-shell rather than flake.nix to avoid full copy of the folder
nix-shell
uv sync

# This can take some times as it will download pytorch > 1GB of package

# then (optionally) check (and generate a sample video)
uv run manim checkhealth

# and you are done
```

**Notes** this is specific to my own homelab setup and can be safely removed
```bash
# enable nvidia GPU on homelab
export __NV_PRIME_RENDER_OFFLOAD=1 
export __GLX_VENDOR_LIBRARY_NAME=nvidia

# this is specific to my setup (nfs shared)
# reposition uv cache on /home/yves/DEV/.uv_cache
# so uv can hardlink (on first uv call)
export UV_CACHE_DIR=/home/yves/DEV/.uv_cache
```

