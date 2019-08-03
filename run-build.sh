#!/bin/env bash

# This script runs your build.sh file in the same environment as CI would.

readonly docker_image=$(head -n1 .gitlab-ci.yml | cut -d' ' -f2)

set -x

time docker run --rm --init \
	--hostname="$HOSTNAME" \
	--volume="$HOME:$HOME" \
	--volume=/etc/passwd:/etc/passwd:ro \
	--volume=/tmp:/tmp \
	--env="HOME=$HOME" \
	--user=$UID:$UID \
	--workdir="$PWD" \
	"$docker_image" \
	/dev/init -sg -- /bin/bash -c ./build.sh
