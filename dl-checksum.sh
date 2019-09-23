#!/usr/bin/env sh
VER=0.58.3
DIR=~/Downloads
MIRROR=https://github.com/gohugoio/hugo/releases/download/v${VER}
CHECKSUMS=hugo_${VER}_checksums.txt
if [ ! -e $DIR/$CHECKSUMS ];
then
    wget -q -O $DIR/$CHECKSUMS $MIRROR/$CHECKSUMS
fi

dl()
{
    local os=$1
    local arch=$2
    local archive_type=$3
    local platform=${os}-${arch}
    local file=hugo_${VER}_${platform}.$archive_type

    printf "    %s: sha256:%s\n" $platform `fgrep $file $DIR/$CHECKSUMS | awk '{print $1}'`
}

printf "  # %s\n" $MIRROR/$CHECKSUMS
printf "  '%s':\n" $VER

dl macOS 32bit tar.gz
dl Windows 32bit zip
dl Windows 64bit zip
dl FreeBSD 64bit tar.gz
dl OpenBSD 64bit tar.gz
dl NetBSD 64bit tar.gz
dl macOS 64bit tar.gz
dl Linux 64bit tar.gz
dl DragonFlyBSD 64bit tar.gz
dl OpenBSD 32bit tar.gz
dl Linux 32bit tar.gz
dl FreeBSD 32bit tar.gz
dl NetBSD 32bit tar.gz
dl Linux ARM tar.gz
dl Linux ARM64 tar.gz
dl OpenBSD ARM tar.gz
dl FreeBSD ARM tar.gz
dl NetBSD ARM tar.gz
