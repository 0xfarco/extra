#!/bin/bash

sudo pacman -S cmake libvips libsixel chafa openssl onetbb opencv xcb-util-image extra-cmake-modules fmt spdlog

git clone https://github.com/0xfarco/ueberzugpp $HOME/Projects/ueberzugpp
cd /home/farco/Projects/ueberzugpp
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .
