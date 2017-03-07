#!/bin/bash

export CXX=$COMPILER

mkdir build
cd build

if [[ $BUILD_TARGET == 'android' ]]; then
#***************#
# Android build #
#***************#
  sh ../scripts/build_android.sh
elif [[ $BUILD_TARGET == 'ios' ]]; then
#***************#
# iOS build     #
#***************#
  sh ../scripts/build_ios.sh
elif [[ $TRAVIS_OS_NAME == 'osx' ]]; then
#************#
# OS X build #
#************#
  cmake .. -DCMAKE_VERBOSE_MAKEFILE=ON -DUSE_OPENCV=off && make -j 4
else
#*************#
# Linux build #
#*************#
  if [[ $BLAS == 'MKL' ]]; then
    cmake .. -DCMAKE_VERBOSE_MAKEFILE=ON -DBLAS=MKL && make -j 4
  else
    cmake .. -DCMAKE_VERBOSE_MAKEFILE=ON && make -j 4
  fi
fi
