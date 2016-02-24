#!/bin/sh -e

WORKING_DIR=$(pwd)

VERSION=${VERSION:-"latest"}

ROOT_DIR=${ROOT_DIR:-"$(pwd)/omnibus"}
INSTALL_DIR=${INSTALL_DIR:-"/opt/sensu"}
OUTPUT_DIR=${OUTPUT_DIR:-"/tmp"}

git clone https://github.com/Homebrew/homebrew.git $ROOT_DIR

cp -r Library $ROOT_DIR/

cd $ROOT_DIR

./bin/brew install sensu

cd $WORKING_DIR

pkgbuild \
    --version "${VERSION}" \
    --identifier "org.sensuapp.sensu" \
    --root "${ROOT_DIR}" \
    --install-location "${INSTALL_DIR}" \
    --filter '/omnibus.sh' \
    --filter '/.git.*$' \
    --filter '/.yardopts' \
    --filter '/.*.md$' \
    --filter '/.*.txt$' \
    --filter '/Library$' \
    --filter '/bin/brew' \
    --filter '/share/doc/homebrew' \
    --filter '/share/man/man1/brew.1' \
    --filter '/.travis.yml' \
    "${OUTPUT_DIR}/sensu-${VERSION}.pkg"
