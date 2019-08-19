#!/usr/bin/env sh
VER=0.57.2
DIR=~/Downloads
MIRROR=https://github.com/gohugoio/hugo/releases/download/v${VER}
CHECKSUMS=hugo_${VER}_checksums.txt

dl()
{
    OS=$1
    ARCH=$2
    ARCHIVETYPE=$3
    PLATFORM=${OS}-${ARCH}
    FILE=hugo_${VER}_${PLATFORM}.$ARCHIVETYPE

    if [ ! -e $DIR/$CHECKSUMS ];
    then
        wget -q -O $DIR/$CHECKSUMS $MIRROR/$CHECKSUMS
    fi

    printf "    %s: sha256:%s\n" $PLATFORM `fgrep $FILE $DIR/$CHECKSUMS | awk '{print $1}'`
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
