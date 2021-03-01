#!/bin/bash
trap 'echo "Exiting..."' EXIT

echo "futurerestore compile script for Linux"
echo "Supported distros: Ubuntu 20.04 and 20.10, Fedora 33"
echo

. /etc/os-release
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib64/pkgconfig:/usr/lib/pkgconfig
mkdir build ; cd build
if [[ $UBUNTU_CODENAME == "focal" ]] || [[ $UBUNTU_CODENAME == "groovy" ]]; then
    sudo add-apt-repository universe
    sudo apt update
    sudo apt install -y pkg-config libtool automake g++ python-dev libzip-dev libcurl4-openssl-dev cmake libssl-dev libusb-1.0-0-dev libreadline-dev libbz2-dev libpng-dev git
elif [[ $ID == "fedora" ]] && (( $VERSION_ID >= 33 )); then
    sudo dnf install -y automake gcc g++ python3-devel git libcurl-devel libtool libusb-devel make libzip-devel openssl-devel pkgconfig readline-devel zlib-devel
elif [[ $ID == "arch" ]] || [[ $ID_LIKE == "arch" ]]; then
    echo "Arch users can install from the AUR: futurerestore-marijuanarm-git"
    exit
else
    echo "Your distro is not supported by this compile script"
    exit 1
fi

rm -rf futurerestore_build
mkdir futurerestore_build
cd futurerestore_build
git clone https://github.com/libimobiledevice/libplist
git clone https://github.com/libimobiledevice/libusbmuxd
git clone https://github.com/libimobiledevice/libimobiledevice 
git clone https://github.com/lzfse/lzfse
git clone https://github.com/libimobiledevice/libirecovery
git clone https://github.com/LukeZGD/libgeneral
git clone https://github.com/LukeZGD/libfragmentzip
git clone https://github.com/LukeZGD/img4tool
git clone --recursive https://github.com/marijuanARM/futurerestore
cd libplist ; ./autogen.sh ; make ; sudo make install ; cd ..
cd libusbmuxd ; ./autogen.sh ; make ; sudo make install ; cd ..
cd libimobiledevice ; ./autogen.sh ; make ; sudo make install ; cd ..
cd lzfse ; make ; sudo make install ; cd ..
cd libirecovery ; ./autogen.sh ; make ; sudo make install ; cd ..
cd libgeneral ; ./autogen.sh --enable-static --disable-shared ; make ; sudo make install ; cd ..
cd libfragmentzip ; ./autogen.sh --enable-static --disable-shared ; make ; sudo make install ; cd ..
cd img4tool ; ./autogen.sh --enable-static --disable-shared ; make ; sudo make install ; cd ..
cd futurerestore ; ./autogen.sh ; make ; sudo make install ; cd ..

sudo ldconfig

echo
echo "Done"
echo "Run futurerestore AT YOUR OWN RISK; Things are not guaranteed to work"
echo
echo "Launching futurerestore after compiling: sudo futurerestore <arguments>"
