#!/bin/bash -e

PWD=$(pwd)

if [ $PWD != '/opt/sensu/embedded' ] ; then
    echo 'Homebrew directory must be `/opt/sensu/embedded` in order to build a Sensu omnibus package.'
    exit 1
fi

PKG_ROOT=$(dirname $PWD)

SENSU_VERSION=${SENSU_VERSION:-"$(./bin/sensu-client -V)-1"}
PKG_VERSION=${PKG_VERSION:-"${SENSU_VERSION}-1"}

OUTPUT_DIR=${OUTPUT_DIR:-"/tmp"}

bin_dir="${PKG_ROOT}/bin"

ln -s ../embedded/bin/sensu-client ${bin_dir}/sensu-client
ln -s ../embedded/bin/sensu-server ${bin_dir}/sensu-server
ln -s ../embedded/bin/sensu-api ${bin_dir}/sensu-api
ln -s ../embedded/bin/sensu-install ${bin_dir}/sensu-install

pkgbuild \
    --version "${VERSION}" \
    --identifier "org.sensuapp.sensu" \
    --root "${PKG_ROOT}" \
    --install-location "${PKG_ROOT}" \
    --filter 'embedded/bin/sensu-create-omnibus.sh' \
    --filter 'embedded/.git.*$' \
    --filter 'embedded/.yardopts' \
    --filter 'embedded/.*.md$' \
    --filter 'embedded/.*.txt$' \
    --filter 'embedded/Library$' \
    --filter 'embedded/bin/brew' \
    --filter 'embedded/share/doc/homebrew' \
    --filter 'embedded/share/man/man1/brew.1' \
    --filter 'embedded/share/emacs' \
    --filter 'embedded/.travis.yml' \
    "${OUTPUT_DIR}/sensu-${PKG_VERSION}.pkg"
