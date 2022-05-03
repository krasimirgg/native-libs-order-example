#!/bin/bash
set -eux

docker build -t "rustc-linkargs-example:latest" .
docker run -it rustc-linkargs-example:latest ./run.sh
docker run -it rustc-linkargs-example:latest ./run.sh nightly
