cd `dirname $0` && cd .. && _rootdir=`pwd`

_update_yazi() {
  local ver="$1"
  local arch="$2"
  local os="$3"

  local pkg="yazi-${arch}-${os}"
  local exe=""
  if [ $os = "pc-windows-msvc" ]; then
    exe=".exe"
  fi

  wget https://github.com/sxyazi/yazi/releases/download/v${ver}/${pkg}.zip
  unzip ${pkg}.zip
  mv "${pkg}/ya${exe}" "$_rootdir/yazi/ya-${ver}-${arch}-${os}${exe}"
  mv "${pkg}/yazi${exe}" "$_rootdir/yazi/yazi-${ver}-${arch}-${os}${exe}"
  rm -rf ./${pkg} ./${pkg}.zip
}
update_yazi() {
  local url="https://api.github.com/repos/sxyazi/yazi/releases/latest"
  local ver=`curl -s "${url}" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | tr -d 'v'`

  rm -rf "$_rootdir/yazi"
  mkdir -p "$_rootdir/yazi"

  _update_yazi "$ver" "x86_64"  "unknown-linux-musl"
  _update_yazi "$ver" "x86_64"  "pc-windows-msvc"
  _update_yazi "$ver" "aarch64" "unknown-linux-musl"
  _update_yazi "$ver" "aarch64" "pc-windows-msvc"
  echo -n "$ver" > "$_rootdir/yazi/VERSION"
}
update_yazi
