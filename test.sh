#!/bin/bash

#install all packages needed for Fuzz testing openssh-portable
sudo apt update
sudo apt install git
sudo apt install zlib1g-dev
sudo apt install libssl-dev
sudo apt install clang
sudo apt install llvm
sudo apt install autoconf
sudo apt update

#clone all the repositories needed for the Fuzz Testing of openssh-portable
git clone https://github.com/google/AFL.git
git clone https://github.com/openssh/openssh-portable.git
#---------------------
cd AFL
make                    #first run the base makefile for AFL 
make -C llvm_mode       #then run this second command to make the "afl-clang-fast" binary


cd ./../openssh-portable
autoreconf
mkdir install
mkdir var-empty

cd ..
sh ./openssh-portable/configure \
    CC="$PWD/AFL/afl-clang-fast" \
    CFLAGS="-g -O3" \
    --prefix=$PWD/openssh-portable/install \
    --with-privsep-path=$PWD/openssh-portable/var-empty \
    --with-sandbox=no \
    --with-privsep-user=dawson

make