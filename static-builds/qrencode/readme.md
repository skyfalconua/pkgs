### build from source

```sh
podman run --rm --arch x86_64 -v `pwd`:/app -it ubuntu:20.04 bash /app/build.sh
podman run --rm --arch aarch64 -v `pwd`:/app -it ubuntu:20.04 bash /app/build.sh

# OR

container run --rm --arch x86_64 -v `pwd`:/app -it ubuntu:20.04 bash /app/build.sh
container run --rm --arch aarch64 -v `pwd`:/app -it ubuntu:20.04 bash /app/build.sh
```
