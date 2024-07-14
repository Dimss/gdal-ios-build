export BUILD_DIR="$HOME/code/watchit/giskit-dependency/build"

mkdir -p  ${BUILD_DIR}/iphoneos/lib

export LIBNAME="libsqlite3"
lipo -create -output \
 $BUILD_DIR/iphoneos/lib/${LIBNAME}.a \
 $BUILD_DIR/iphoneos_arm64/lib/${LIBNAME}.a

export LIBNAME="libproj"
lipo -create -output \
 $BUILD_DIR/iphoneos/lib/${LIBNAME}.a \
 $BUILD_DIR/iphoneos_arm64/lib/${LIBNAME}.a

export LIBNAME="libgdal"
lipo -create -output \
 $BUILD_DIR/iphoneos/lib/${LIBNAME}.a \
 $BUILD_DIR/iphoneos_arm64/lib/${LIBNAME}.a

rm -fr $BUILD_DIR/include_sqlite3
rm -fr $BUILD_DIR/include_proj
rm -fr $BUILD_DIR/include_gdal
mkdir -p $BUILD_DIR/include_sqlite3 $BUILD_DIR/include_proj $BUILD_DIR/include_gdal
cp -r $BUILD_DIR/iphoneos_arm64/include/* $BUILD_DIR/include_gdal/
mv $BUILD_DIR/include_gdal/sqlite3* $BUILD_DIR/include_sqlite3/
mv $BUILD_DIR/include_gdal/proj* $BUILD_DIR/include_proj/

export FRAMENAME=sqlite3
export LIBNAME=libsqlite3
export PLATFORM=iphoneos
export FRAMEPATH="$BUILD_DIR/${PLATFORM}/${FRAMENAME}.framework"
rm -fr "${FRAMEPATH}"
mkdir -p "${FRAMEPATH}/Headers"
cp -a "${BUILD_DIR}/include_${FRAMENAME}/" "${FRAMEPATH}/Headers"
cp -a "${BUILD_DIR}/${PLATFORM}/lib/${LIBNAME}.a" "${FRAMEPATH}/${FRAMENAME}.a"

export FRAMENAME=proj
export LIBNAME=libproj
export PLATFORM=iphoneos
export FRAMEPATH="$BUILD_DIR/${PLATFORM}/${FRAMENAME}.framework"
rm -fr "${FRAMEPATH}"
mkdir -p "${FRAMEPATH}/Headers"
cp -a "${BUILD_DIR}/include_${FRAMENAME}/" "${FRAMEPATH}/Headers"
cp -a "${BUILD_DIR}/${PLATFORM}/lib/${LIBNAME}.a" "${FRAMEPATH}/${FRAMENAME}.a"

export FRAMENAME=gdal
export LIBNAME=libgdal
export PLATFORM=iphoneos
export FRAMEPATH="$BUILD_DIR/${PLATFORM}/${FRAMENAME}.framework"
rm -fr "${FRAMEPATH}"
mkdir -p "${FRAMEPATH}/Headers"
cp -a "${BUILD_DIR}/include_${FRAMENAME}/" "${FRAMEPATH}/Headers"
cp -a "${BUILD_DIR}/${PLATFORM}/lib/${LIBNAME}.a" "${FRAMEPATH}/${FRAMENAME}.a"



#
rm -fr "${BUILD_DIR}/xcf"
mkdir -p "${BUILD_DIR}/xcf"

export FRAMENAME=sqlite3
xcodebuild -create-xcframework \
 -library "${BUILD_DIR}/iphoneos/${FRAMENAME}.framework/${FRAMENAME}.a" \
 -headers "${BUILD_DIR}/iphoneos/${FRAMENAME}.framework/Headers" \
 -output "${BUILD_DIR}/xcf/${FRAMENAME}.xcframework"
#cp ../modulemaps/${FRAMENAME}.module.modulemap "${BUILD_DIR}/xcf/${FRAMENAME}.xcframework/ios-arm64/Headers/module.modulemap"
#
##
export FRAMENAME=proj
xcodebuild -create-xcframework \
 -library "${BUILD_DIR}/iphoneos/${FRAMENAME}.framework/${FRAMENAME}.a" \
 -headers "${BUILD_DIR}/iphoneos/${FRAMENAME}.framework/Headers" \
 -output "${BUILD_DIR}/xcf/${FRAMENAME}.xcframework"
#cp ../modulemaps/${FRAMENAME}.module.modulemap "${BUILD_DIR}/xcf/${FRAMENAME}.xcframework/ios-arm64/Headers/module.modulemap"

export FRAMENAME=gdal
xcodebuild -create-xcframework \
 -library "${BUILD_DIR}/iphoneos/${FRAMENAME}.framework/${FRAMENAME}.a" \
 -headers "${BUILD_DIR}/iphoneos/${FRAMENAME}.framework/Headers" \
 -output "${BUILD_DIR}/xcf/${FRAMENAME}.xcframework"
cp ../modulemaps/${FRAMENAME}.module.modulemap "${BUILD_DIR}/xcf/${FRAMENAME}.xcframework/ios-arm64/Headers/module.modulemap"


#ls -F | grep -v / | awk '{print "\t header " "\"" $1"\""}'