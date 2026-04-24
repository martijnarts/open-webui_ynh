#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

# Install open-webui into the app's venv.
#
# On CPU-only hosts, torch is pre-installed from the CPU-only index so pip's
# dependency resolver doesn't pull the default PyPI wheel (which bundles ~6 GB
# of CUDA libraries that are unusable without an NVIDIA driver).
install_openwebui() {
    pushd "$install_dir"
        venv/bin/pip install --upgrade pip setuptools wheel
        if [ "${use_gpu:-0}" -eq 1 ]; then
            ynh_print_info "Installing torch with CUDA support (use_gpu=1)"
        else
            ynh_print_info "Installing CPU-only torch (use_gpu=0)"
            venv/bin/pip install torch --index-url https://download.pytorch.org/whl/cpu
        fi
        venv/bin/pip install open-webui=="$upstream_version"
    popd
}
