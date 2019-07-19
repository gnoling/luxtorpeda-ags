#!/bin/bash
set -x

# log environment and tool versions you care about here:
pwd
nproc
gcc --version

# build instructions
cd source || exit 0
