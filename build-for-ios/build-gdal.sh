source build-ios.sh

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
    -DGDAL_USE_INTERNAL_LIBS=ON \
    -DGDAL_USE_LIBXML2=OFF \
    -DGDAL_USE_ICONV=OFF \
    -DCMAKE_BUILD_TYPE=Release \
    -DGDAL_USE_JXL=OFF \
    -DGDAL_USE_OPENSSL=OFF \
    -DGDAL_USE_ZSTD=OFF \
    -DGDAL_USE_WEBP=OFF \
    -DGDAL_USE_OPENJPEG=OFF \
    -DGDAL_USE_LIBLZMA=OFF \
    -DGDAL_USE_LIBKML=OFF \
    -DGDAL_USE_EXPAT=OFF \
    ..
cmake --build .
cmake --build . --target install