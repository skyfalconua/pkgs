export VERSION="4.1.1"
export ARCH=`uname -m`
export DEBIAN_FRONTEND=noninteractive
export TZ=Etc/UTC

apt update && apt install -y build-essential autoconf libtool \
  pkg-config libpng-dev curl git

# -- build app -- -- --

git clone --depth=1 https://github.com/fukuchi/libqrencode.git && \
cd libqrencode && git checkout v$VERSION
bash autogen.sh && ./configure --enable-static --disable-shared && make

# -- copy files -- -- --

mv qrencode /app/qrencode-$VERSION-$ARCH
echo $VERSION > /app/VERSION
