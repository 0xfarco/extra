#!/bin/bash
set -e

# Ensure bin directory exists
mkdir -p "$HOME/.local/bin"

# Install dependencies
sudo pacman -S --noconfirm cmake libvips libsixel chafa openssl onetbb xcb-util-image extra-cmake-modules fmt spdlog range-v3 cli11 nlohmann-json

# Clone and build ueberzugpp
git clone https://github.com/0xfarco/ueberzugpp "$HOME/.local/src/ueberzugpp"
cd "$HOME/.local/src/ueberzugpp"
mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .

# Copy the binary
cp ueberzugpp "$HOME/.local/bin/"

