source build-mac.sh

cd src/gdal \
  && rm -r build_$OS; mkdir build_$OS; cd build_$OS

cmake -DCMAKE_TOOLCHAIN_FILE=$CMTOOLCHAIN \
    -DPLATFORM=$OS \
    -DENABLE_BITCODE=OFF \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DBUILD_SHARED_LIBS=OFF \
    -DBUILD_APPS=OFF \
    -DBUILD_PYTHON_BINDINGS=OFF \
    -DPROJ_ROOT=$PREFIX \
    -DSQLITE3_INCLUDE_DIR=$PREFIX/include \
    -DSQLITE3_LIBRARY=$PREFIX/lib/libsqlite3.a \
    -DIconv_INCLUDE_DIR=$SDKPATH/usr \
    -DIconv_LIBRARY=$SDKPATH/usr/lib/libiconv.tbd \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH=/opt/homebrew/Cellar \
    -DGDAL_USE_JXL=OFF \
    ..
cmake --build .
cmake --build . --target install