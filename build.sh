#!/bin/bash

set -x

# log environment and tool versions you care about here:
pwd
nproc
git --version
gcc --version

# record metadata
mkdir dist
touch dist/manifest
echo "version: $(git -C source describe --always)" >> dist/manifest || true
echo "package version: $(git describe --always)" >> dist/manifest

# build instructions
pushd source || exit 0

# place resulting binaries in directory 'dist'
