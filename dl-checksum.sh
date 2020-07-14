#!/usr/bin/env sh
DIR=~/Downloads
MIRROR=https://github.com/gohugoio/hugo/releases/download
APP=hugo

dl()
{
    local ver=$1
    local lchecksums=$2
    local os=$3
    local arch=$4
    local archive_type=$5
    local platform=${os}-${arch}
    local file=${APP}_${ver}_${platform}.${archive_type}
    local url=$MIRROR/v$ver/$file

    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform `fgrep $file $lchecksums | awk '{print $1}'`
}

dl_ver() {
    local ver=$1
    local checksums=${APP}_${ver}_checksums.txt
    local lchecksums=$DIR/$checksums
    local rchecksums=$MIRROR/v$ver/$checksums
    if [ ! -e $lchecksums ];
    then
        wget -q -O $lchecksums $rchecksums
    fi
    printf "  # %s\n" $rchecksums
    printf "  '%s':\n" $ver


    dl $ver $lchecksums macOS 32bit tar.gz
    dl $ver $lchecksums Windows 32bit zip
    dl $ver $lchecksums Windows 64bit zip
    dl $ver $lchecksums FreeBSD 64bit tar.gz
    dl $ver $lchecksums OpenBSD 64bit tar.gz
    dl $ver $lchecksums NetBSD 64bit tar.gz
    dl $ver $lchecksums macOS 64bit tar.gz
    dl $ver $lchecksums Linux 64bit tar.gz
    dl $ver $lchecksums DragonFlyBSD 64bit tar.gz
    dl $ver $lchecksums OpenBSD 32bit tar.gz
    dl $ver $lchecksums Linux 32bit tar.gz
    dl $ver $lchecksums FreeBSD 32bit tar.gz
    dl $ver $lchecksums NetBSD 32bit tar.gz
    dl $ver $lchecksums Linux ARM tar.gz
    dl $ver $lchecksums Linux ARM64 tar.gz
    dl $ver $lchecksums OpenBSD ARM tar.gz
    dl $ver $lchecksums FreeBSD ARM tar.gz
    dl $ver $lchecksums NetBSD ARM tar.gz
}

dl_ver ${1:-0.74.1}
