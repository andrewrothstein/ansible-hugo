#!/usr/bin/env sh
set -e
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
    printf "    %s: sha256:%s\n" $platform $(grep $file $lchecksums | awk '{print $1}')
}

dl_ver() {
    local ver=$1
    local checksums=${APP}_${ver}_checksums.txt
    local lchecksums=$DIR/$checksums
    local rchecksums=$MIRROR/v$ver/$checksums
    if [ ! -e $lchecksums ];
    then
        curl -sSLf -o $lchecksums $rchecksums
    fi
    printf "  # %s\n" $rchecksums
    printf "  '%s':\n" $ver

    dl $ver $lchecksums windows amd64 zip
    dl $ver $lchecksums freebsd amd64 tar.gz
    dl $ver $lchecksums openbsd amd64 tar.gz
    dl $ver $lchecksums netbsd amd64 tar.gz
    dl $ver $lchecksums darwin universal tar.gz
    dl $ver $lchecksums linux amd64 tar.gz
    dl $ver $lchecksums linux arm tar.gz
    dl $ver $lchecksums linux arm64 tar.gz
}

dl_ver ${1:-0.106.0}
