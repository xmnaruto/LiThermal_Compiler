#!/bin/bash
ROOTPATH=`pwd`


export STAGING_DIR=$ROOTPATH/target
mkdir build
cd build
cmake $ROOTPATH/LiThermal -DROOTPATH=$ROOTPATH -DCMAKE_TOOLCHAIN_FILE=$ROOTPATH/LiThermal/toolchain.cmake
make -j`nproc`

# compile BSOD
$ROOTPATH/toolchain-sunxi-musl/toolchain/bin/arm-openwrt-linux-gcc -o $ROOTPATH/build/BSOD $ROOTPATH/LiThermal/tools/BSOD.c

# Get all compiled files
if [ ! -d $ROOTPATH/UDISK ]; then
    mkdir $ROOTPATH/UDISK
fi
cp $ROOTPATH/build/LiThermal $ROOTPATH/UDISK
cp $ROOTPATH/build/BSOD $ROOTPATH/UDISK
cp $ROOTPATH/thermalcamera.sh $ROOTPATH/UDISK
