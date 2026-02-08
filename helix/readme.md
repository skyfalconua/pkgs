### download

```sh
helixver="25.07.1"
curl -sL "skyfalconua.github.io/pkgs/helix/helix-${helixver}-$(uname -m).tgz" | tar xz -C /opt && \
chmod 755 /opt/helix/hx && \
ln -sfv /opt/helix/hx "$HOME/.dotfiles/bin/hx"
```

### build from source

```sh
# rustc --print target-list
#   x86_64-unknown-linux-gnu
#   aarch64-unknown-linux-gnu

# podman run --rm --arch x86_64 -v `pwd`:/app -it ubuntu:20.04
# podman run --rm --arch aarch64 -v `pwd`:/app -it ubuntu:20.04

# -- EITHER stable or latest -- -- --

VERSION="25.07.1"
# --
VERSION=`date +"%Y.%-m.%-d"`

# -- prepare -- -- --

pkgname="helix-$VERSION-$(uname -m)"
pkgroot="/tmp/app/$pkgname"
rustarch="$(uname -m)-unknown-linux-gnu"

mkdir -p $pkgroot/opt/helix && \
cd /tmp/app

# -- install deps -- -- --

apt update && apt install -y build-essential curl git && \
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain none -y && \
source "$HOME/.cargo/env"

# -- EITHER stable or latest -- -- --

git clone https://github.com/helix-editor/helix --single-branch --branch=$VERSION --depth=1 && \
cd helix && git checkout $VERSION
# --
git clone https://github.com/helix-editor/helix && \
cd helix

# -- build app -- -- --

rustver=`cat Cargo.toml | grep rust-version | cut -d '"' -f 2`
rustup toolchain install $rustver --profile minimal
cargo install --target=$rustarch --path helix-term --locked

# -- optional fix of grammar -- -- --
# cd runtime/grammars/sources
# git clone https://git.sr.ht/~ecs/tree-sitter-hare
# cd hare && git pull
# git checkout __failed_commit__
# cd /tmp/app/helix

# -- copy files -- -- --

cd $pkgroot && \
cp $HOME/.cargo/bin/hx opt/helix && \
chmod 755 opt/helix/hx && \
cp -r ../helix/runtime opt/helix && \
rm -rf opt/helix/runtime/grammars/sources && \
cp -r ../helix/contrib opt/helix

cd $pkgroot/opt && \
COPYFILE_DISABLE=1 tar --no-xattrs -cvzf "/tmp/app/$pkgname.tgz" helix && \
cp "/tmp/app/$pkgname.tgz" "/app/$pkgname.tgz"
```
