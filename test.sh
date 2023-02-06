#!/bin/bash

rm -rf *

#install all packages needed for Fuzz testing openssh-portable
sudo apt-get update
sudo apt-get -y install git
sudo apt-get -y install zlib1g-dev
sudo apt-get -y install libssl-dev
sudo apt-get -y install clang
sudo apt-get -y install llvm
sudo apt-get -y install autoconf
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
make install
rm -rf /home/dawson/Dasktop/OUT/0
sudo -S <<< "dq29shana" -- sh -c "chown jenkin:jenkin /home/dawson/Desktop/OUT"
sudo -S <<< "dq29shana" -- sh -c "chmod 777 /home/dawson/Desktop/OUT"
./AFL/afl-fuzz -x sshd.dict -i /home/dawson/Desktop/IN -o /home/dawson/Desktop/OUT -M 0 -- ./sshd -d -e -p 2222 -r -f ./openssh-portable/sshd_config -i
sudo -S <<< "dq29shana" | cp output /mnt/local_share/FuzzOut
