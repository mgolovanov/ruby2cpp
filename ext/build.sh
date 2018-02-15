#!/bin/sh
swig -c++ -ruby libhello.i
ruby extconf.rb
make CPPFLAGS="-std=c++11"
make install
mkdir -p ../lib
cp libhello.so ../lib
