#!/bin/sh

ROOT=`pwd`
SOURCE="$ROOT/.."
IOS_DEPLOY_TGT="9.0"

FAT="$ROOT/fat"
THIN="$ROOT/thin"
FRAMEWORK="$ROOT/framework/MP4v2.framework"
FRAMEWORK_BIN="MP4v2"
LIBFILE="libmp4v2.a"


ARCHS="i386 x86_64 arm64 armv7 armv7s"
CONFIGURE_FLAGS="--disable-gch --disable-debug --disable-util \
                  --enable-shared=no"

clean()
{
  rm -rf $THIN
  rm -rf $FAT
  rm -rf $FRAMEWORK
}

clean

for ARCH in $ARCHS
do
  echo "building $ARCH .."

  CFLAGS="-arch $ARCH"
  if [ "$ARCH" = "i386" -o "$ARCH" = "x86_64" ]
  then
    CFLAGS="$CFLAGS -mios-simulator-version-min=$IOS_DEPLOY_TGT"
    SDKROOT=`xcode-select -p`/"Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk"
  else
	CFLAGS="$CFLAGS -mios-version-min=$IOS_DEPLOY_TGT"
	SDKROOT=`xcode-select -p`/"Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk"
  fi

  if [ "$ARCH" = "i386" ]
  	then
  	HOST="--host=i386-apple-darwin7"
  elif [ "$ARCH" = "x86_64" ]
  	then
  	HOST="--host=x86_64-apple-darwin7"
  else
  	HOST="--host=arm-apple-darwin7"
  fi

  CFLAGS="$CFLAGS -pipe -no-cpp-precomp -isysroot $SDKROOT -I$SDKROOT/usr/include/"

  export CFLAGS="$CFLAGS"

  export CXX="llvm-g++"
  export CC="llvm-gcc"

  export LD=$DEVROOT/usr/bin/ld
  export AR=$DEVROOT/usr/bin/ar
  export AS=$DEVROOT/usr/bin/as
  export NM=$DEVROOT/usr/bin/nm
  export RANLIB=$DEVROOT/usr/bin/ranlib
  export LDFLAGS="-L$SDKROOT/usr/lib/"
  export LIBTOOL=$DEVROOT/usr/bin/libtool
  export LIPO=$DEVROOT/usr/bin/lipo
  export OTOOL=$DEVROOT/usr/bin/otool
  export NMEDIT=$DEVROOT/usr/bin/nmedit
  export DSYMUTIL=$DEVROOT/usr/bin/dsymutil
  export STRIP=$DEVROOT/usr/bin/strip

  export CPPFLAGS=$CFLAGS
  export CXXFLAGS=$CFLAGS
  
  pushd $SOURCE
  make distclean
  ./configure $HOST $CONFIGURE_FLAGS
  make
  make install
  popd

  mkdir -p $THIN/$ARCH/lib
  cp $SOURCE/.libs/$LIBFILE $THIN/$ARCH/lib/
  cp -R $SOURCE/include $THIN/$ARCH/

  echo "build $ARCH done.."
done

echo "building fat .."

mkdir -p $FAT/lib
lipo -create `find $THIN -name $LIBFILE` -output $FAT/lib/$LIBFILE
cp -R $SOURCE/include $FAT/

mkdir -p $FRAMEWORK/Headers
cp $FAT/lib/$LIBFILE $FRAMEWORK/$FRAMEWORK_BIN
chmod a+x $FRAMEWORK/$FRAMEWORK_BIN
cp $FAT/include/mp4v2/*.* $FRAMEWORK/Headers/

echo "build fat done.."
