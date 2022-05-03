#!/bin/bash

set -u

RUN_DIR=$(dirname "$(readlink -f "$BASH_SOURCE")")
cd $RUN_DIR

if [ ${1:-no} == "nightly" ]; then
  rustup default nightly-2022-05-02
else
  rustup default stable
fi

gcc --version
rustc --version
ld.lld --version

echo 'Creating native library foo'
gcc -c foo.cc -o foo.o
ar cr libfoo.a foo.o

echo 'Building rust rlib bar'
rustc --crate-type=rlib bar.rs

echo 'Building rust bin main'
rustc -Clink-args="-fuse-ld=lld -Wl,--warn-backrefs -Wl,--fatal-warnings" -Ccodegen-units=1 --crate-type=bin main.rs -Lnative=$RUN_DIR -lstatic=foo --extern=bar=libbar.rlib || true

echo 'Cleaning up'
rm $RUN_DIR/{*.o,*.a,main}
