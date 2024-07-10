source build-ios.sh
cd src/sqlite-amalgamation \
  && rm -r build_$OS; mkdir build_$OS; cd build_$OS

cmake -DCMAKE_TOOLCHAIN_FILE=$CMTOOLCHAIN \
    -DPLATFORM=$OS \
    -DENABLE_BITCODE=OFF \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DBUILD_SHARED_LIBS=OFF \
    -DSQLITE_ENABLE_RTREE=ON \
    -DSQLITE_ENABLE_COLUMN_METADATA=ON \
    -DSQLITE_OMIT_DECLTYPE=OFF \
    ..
cmake --build .
cmake --build . --target install