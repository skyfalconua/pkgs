apt update && DEBIAN_FRONTEND=noninteractive apt install -y build-essential curl git

mver=`date +"%y.%-m.%-d"`
gver=`curl -s 'https://go.dev/VERSION?m=text' | head -n 1 | sed 's/^go//'`
arch=""
case "$(uname -m)" in
  x86_64)  arch="amd64" ;;
  aarch64) arch="arm64" ;;
  *)       echo "error: unknown architecture"; exit ;;
esac

cd /tmp

# -- install deps -- -- --

mkdir -p /tmp/golib
gopkg="go$gver.linux-$arch.tar.gz"
curl -L "https://go.dev/dl/$gopkg" -o $gopkg
tar -xzf $gopkg

export PATH=$PATH:/tmp/go/bin
export GOPATH=/tmp/golib

# -- build app -- -- --

git clone --depth=1 https://github.com/zyedidia/micro && cd /tmp/micro
git tag v$mver && git checkout v$mver && make build

# -- copy files -- -- --

mv /tmp/micro/micro /app/micro-$mver-$(uname -m)
echo $mver > /app/VERSION
