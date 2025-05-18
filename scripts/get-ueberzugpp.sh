#!/bin/bash
set -e

# Ensure bin directory exists
#mkdir -p "$HOME/.local/bin"
#mkdir -p "$HOME/.local/src"

# Detect distribution
if [ -f /etc/arch-release ]; then
    DISTRO="arch"
elif [ -f /etc/void-release ]; then
    DISTRO="void"
else
    echo "Unsupported distribution"
    exit 1
fi

# Install dependencies
if [ "$DISTRO" = "arch" ]; then
    sudo pacman -S --noconfirm cmake libvips libsixel chafa openssl onetbb xcb-util-image extra-cmake-modules fmt spdlog range-v3 cli11 nlohmann-json opencv
elif [ "$DISTRO" = "void" ]; then
    sudo xbps-install -Sy cmake libvips libsixel chafa openssl tbb xcb-util-image fmt spdlog range-v3 extra-cmake-modules opencv
fi

# Clone and build ueberzugpp
git clone https://github.com/0xfarco/ueberzugpp "$HOME/.local/src/ueberzugpp"
cd "$HOME/.local/src/ueberzugpp"
mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .

# Copy the binary
cp ueberzugpp "$HOME/.local/bin/"

