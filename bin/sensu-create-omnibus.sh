#!/bin/bash -e

PWD=$(pwd)

if [ $PWD != '/opt/sensu/embedded' ] ; then
    echo 'Homebrew directory must be `/opt/sensu/embedded` in order to build a Sensu omnibus package.'
    exit 1
fi

PKG_ROOT=$(dirname $PWD)

SENSU_VERSION=${SENSU_VERSION:-"$(./bin/sensu-client -V)"}
PKG_VERSION=${PKG_VERSION:-"${SENSU_VERSION}-1"}

OUTPUT_DIR=${OUTPUT_DIR:-"/tmp"}

bin_dir="${PKG_ROOT}/bin"

rm -rf $bin_dir
mkdir $bin_dir

ln -s ../embedded/bin/sensu-client ${bin_dir}/sensu-client
ln -s ../embedded/bin/sensu-server ${bin_dir}/sensu-server
ln -s ../embedded/bin/sensu-api ${bin_dir}/sensu-api

cat <<EOF
EOM >${bin_dir}/sensu-install
#!/bin/bash

/opt/sensu/embedded/bin/ruby /opt/sensu/embedded/bin/sensu-install $@
EOF

pkg_scripts="${PKG_ROOT}/Cellar/sensu/${SENSU_VERSION}/scripts"

pkgbuild \
    --version "${PKG_VERSION}" \
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
    --scripts "${pkg_scripts}" \
    "${OUTPUT_DIR}/sensu-${PKG_VERSION}.pkg"
