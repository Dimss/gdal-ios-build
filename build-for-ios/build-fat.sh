export BUILD_DIR="$HOME/code/watchit/giskit-dependency/build"

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
mkdir -p "${FRAMEPATH}/Headers"
#ln -sfh "A" "${FRAMEPATH}/Versions/Current"
#ln -shf "Versions/Current/Headers" "${FRAMEPATH}/Headers"
#ln -sfh "Versions/Current/${FRAMENAME}" "${FRAMEPATH}/${FRAMENAME}"
cp -a "${BUILD_DIR}/include_${FRAMENAME}/" "${FRAMEPATH}/Headers"
cp -a "${BUILD_DIR}/${PLATFORM}/lib/${LIBNAME}.a" "${FRAMEPATH}/${FRAMENAME}"

export FRAMENAME=proj
export LIBNAME=libproj
export PLATFORM=iphoneos
export FRAMEPATH="$BUILD_DIR/${PLATFORM}/${FRAMENAME}.framework"
mkdir -p "${FRAMEPATH}/Versions/A/Headers"
ln -sfh "A" "${FRAMEPATH}/Versions/Current"
ln -shf "Versions/Current/Headers" "${FRAMEPATH}/Headers"
ln -sfh "Versions/Current/${FRAMENAME}" "${FRAMEPATH}/${FRAMENAME}"
cp -a "${BUILD_DIR}/include_${FRAMENAME}/" "${FRAMEPATH}/Versions/A/Headers"
cp -a "${BUILD_DIR}/${PLATFORM}/lib/${LIBNAME}.a" "${FRAMEPATH}/Versions/A/${FRAMENAME}"

export FRAMENAME=gdal
export LIBNAME=libgdal
export PLATFORM=iphoneos
export FRAMEPATH="$BUILD_DIR/${PLATFORM}/${FRAMENAME}.framework"
mkdir -p "${FRAMEPATH}/Versions/A/Headers"
ln -sfh "A" "${FRAMEPATH}/Versions/Current"
ln -shf "Versions/Current/Headers" "${FRAMEPATH}/Headers"
ln -sfh "Versions/Current/${FRAMENAME}" "${FRAMEPATH}/${FRAMENAME}"
cp -a "${BUILD_DIR}/include_${FRAMENAME}/" "${FRAMEPATH}/Versions/A/Headers"
cp -a "${BUILD_DIR}/${PLATFORM}/lib/${LIBNAME}.a" "${FRAMEPATH}/Versions/A/${FRAMENAME}"


rm -fr "${BUILD_DIR}/xcf"
mkdir -p "${BUILD_DIR}/xcf"

export FRAMENAME=sqlite3
xcodebuild -create-xcframework \
-framework "${BUILD_DIR}/iphoneos/${FRAMENAME}.framework" \
-output "${BUILD_DIR}/xcf/${FRAMENAME}.xcframework"

export FRAMENAME=proj
xcodebuild -create-xcframework \
-framework "${BUILD_DIR}/iphoneos/${FRAMENAME}.framework" \
-output "${BUILD_DIR}/xcf/${FRAMENAME}.xcframework"

export FRAMENAME=gdal
xcodebuild -create-xcframework \
-framework "${BUILD_DIR}/iphoneos/${FRAMENAME}.framework" \
-output "${BUILD_DIR}/xcf/${FRAMENAME}.xcframework"