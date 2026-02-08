### download

```sh
neovimver="0.11.5"
curl -sL "skyfalconua.github.io/pkgs/neovim/neovim-${neovimver}-$(uname -m).tgz" | tar xz -C /opt && \
chmod 755 /opt/neovim/bin/nvim && \
ln -sfv /opt/neovim/bin/nvim "$HOME/.dotfiles/bin/nvim"
```

### build from source

```sh
podman run --rm --arch x86_64  -v `pwd`:/app -it alpine:latest sh /app/build.sh
podman run --rm --arch aarch64 -v `pwd`:/app -it alpine:latest sh /app/build.sh

# OR

# optional --cpu 8 --memory 4G
container run --rm --arch x86_64  -v `pwd`:/app -it alpine:latest sh /app/build.sh
container run --rm --arch aarch64 -v `pwd`:/app -it alpine:latest sh /app/build.sh
```
