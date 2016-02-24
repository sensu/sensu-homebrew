#!/bin/sh -e

ROOT_DIR=$(pwd)

VERSION=${VERSION:-"$(./bin/sensu-client -V)-1"}

INSTALL_DIR=${INSTALL_DIR:-"/opt/sensu/embedded"}
OUTPUT_DIR=${OUTPUT_DIR:-"/tmp"}

pkgbuild \
    --version "${VERSION}" \
    --identifier "org.sensuapp.sensu" \
    --root "${ROOT_DIR}" \
    --install-location "${INSTALL_DIR}" \
    --filter '/bin/sensu-create-omnibus.sh' \
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
