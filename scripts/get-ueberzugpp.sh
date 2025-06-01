#!/bin/bash
set -e

# Ensure bin and src directories exist
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/src"

# Detect distribution
if grep -qi '^ID=arch' /etc/os-release || grep -qi '^ID=artix' /etc/os-release; then
    DISTRO="arch"
elif grep -qi '^ID=void' /etc/os-release; then
    DISTRO="void"
else
    echo "Unsupported distribution"
    exit 1
fi

# Install dependencies
if [ "$DISTRO" = "arch" ]; then
    sudo pacman -S --noconfirm cmake git libvips libsixel chafa openssl onetbb xcb-util-image extra-cmake-modules fmt spdlog range-v3 cli11 nlohmann-json opencv
elif [ "$DISTRO" = "void" ]; then
    sudo xbps-install -Sy cmake git libvips-devel libsixel-devel chafa-devel openssl-devel tbb-devel xcb-util-image-devel fmt spdlog range-v3 extra-cmake-modules libopencv-devel nlohmann-json
fi

# Clone and build ueberzugpp
REPO_DIR="$HOME/.local/src/ueberzugpp"

if [ -d "$REPO_DIR" ]; then
    echo "Directory $REPO_DIR already exists. Skipping clone."
else
    git clone https://github.com/0xfarco/ueberzugpp "$REPO_DIR"
fi

cd "$REPO_DIR"
mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build . -- -j"$(nproc)"

# Copy the binary
cp ueberzugpp "$HOME/.local/bin/"

