### build from source

```sh
podman run --rm --arch x86_64  -v `pwd`:/app -it alpine:latest sh /app/build.sh
podman run --rm --arch aarch64 -v `pwd`:/app -it alpine:latest sh /app/build.sh

# OR

# optional --cpu 8 --memory 4G
container run --rm --arch x86_64  -v `pwd`:/app -it alpine:latest sh /app/build.sh
container run --rm --arch aarch64 -v `pwd`:/app -it alpine:latest sh /app/build.sh
```
