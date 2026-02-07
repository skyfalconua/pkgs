ver="0.11.5"
arch=$(uname -m)
mkdir -p /tmp/app/neovim
apk add build-base cmake coreutils curl gettext-tiny-dev git

curl -L "https://github.com/neovim/neovim/archive/refs/tags/v${ver}.tar.gz" > src.tgz
tar -xf src.tgz
cd "neovim-${ver}"

make CMAKE_EXTRA_FLAGS="-DSTATIC_BUILD=1"
cp -rf build/bin /tmp/app/neovim

curl -L "https://github.com/neovim/neovim/releases/download/v${ver}/nvim-linux-x86_64.tar.gz" > pkg.tgz
tar -xf pkg.tgz
cp -rf nvim-linux-x86_64/share /tmp/app/neovim

cd /tmp/app
COPYFILE_DISABLE=1 tar -cvzf "neovim-${ver}-${arch}.tgz" neovim

mv "neovim-${ver}-${arch}.tgz" /app
echo $ver > /app/VERSION
