#!/bin/bash
#Script for the easy installation of AMD Drivers on HiveOS/Ubuntu based OS
#Script By CryptoLuigi (Michael Ruperto)
#Date: 2019-04-21
#Contributors: miabo Cryptonuffe

echo
#mkdir /hive-drivers-pack/
cd /gpu_installer/
echo "This script will install the drivers needed for AMD GPU OpenCL RX580 + NAVI"
PS3='Please enter your choice Drivers: '

options=("20.40-1147286" "Quit")

select opt in "${options[@]}"
do
case $opt in
    "16.40-348864-ubuntu-16.04")
    wget https://drivers.amd.com/drivers/linux/amdgpu-pro-20.40-1147286-ubuntu-20.04.tar.xz --referer https://www.amd.com/en/support/kb/release-notes/rn-amdgpu-unified-linux-20-40
        version="20.40-1147286";break
	;;
	"Quit")
	exit
        break
    ;;
    *)
        echo "Invalid option $REPLY"
    ;;
    esac
done

echo
read -p "Do you want have RX4xx/RX5xx?(y/n)" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    tar -Jxvf amdgpu-pro-$version.tar.xz
    echo
    read -p "Do you want remove current AMD Drivers?(y/n)" -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then
		/usr/bin/amdgpu-pro-uninstall
		apt-get remove vulkan-amdgpu-pro*
	fi
	cd amdgpu-pro-$version
    apt-get -f install
    ./amdgpu-pro-install -y --opencl=pal,legacy,rocm --headless
    dpkg -l amdgpu-pro
    exit
fi

tar -Jxvf amdgpu-pro-$version.tar.xz
cd amdgpu-pro-$version
./amdgpu-pro-install -y --opencl=pal,legacy,rocm --headless
