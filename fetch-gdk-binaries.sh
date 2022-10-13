#!/usr/bin/env bash

# https://github.com/Blockstream/green_ios/blob/master/tools/fetch_gdk_binaries.sh

# Downloads and installs the pre-built gdk libraries for use by green_ios
set -e

# The version of gdk to fetch and its sha256 checksum for integrity checking
NAME="gdk-iphone"
SHA256="5a61a01dab7d97acd9116b4af130cf0ddc2c542bef630d4944091c622a814b5f"

if [[ $1 == "--simulator" ]]; then
    # Get version for iphone simulator
    NAME="gdk-iphone-sim"
    SHA256="67fc18ea334df575cb02c4500c1c294224577321710a961c4feeef87b2dc46ca"
fi

# Setup gdk version and url
VERSION="release_0.0.55"
TARBALL="${NAME}.tar.gz"
URL="https://github.com/Blockstream/gdk/releases/download/${VERSION}/${TARBALL}"

# Pre-requisites
function check_command() {
    command -v $1 >/dev/null 2>&1 || { echo >&2 "$1 not found, exiting."; exit 1; }
}
check_command curl
check_command gzip
check_command shasum

# Find out where we are being run from to get paths right
if [ ! -d "$(pwd)/ios" ]; then
    echo "Run fetch script from gaios project root folder"
    exit 1
fi

# Clean up any previous install
rm -rf gdk-iphone

# Fetch, validate and decompress gdk
curl -sL -o ${TARBALL} "${URL}"
echo "${SHA256}  ${TARBALL}" | shasum -a 256 --check
tar xf ${TARBALL}
rm ${TARBALL}
if [[ $1 == "--simulator" ]]; then
    mv -f ${NAME} "gdk-iphone"
    # fetching binaries for simulator should put its files in the /iphone/ folder anyway to prevent compilation errors
    mv gdk-iphone/lib/iphonesim gdk-iphone/lib/iphone
fi
