#!/bin/bash

#install all packages needed for Fuzz testing openssh-portable
sudo apt-get update
sudo apt-get install git
sudo apt-get install zlib1g-dev
sudo apt-get install libssl-dev
sudo apt-get install clang
sudo apt-get install llvm
sudo apt-get install autoconf
sudo apt-get update

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
