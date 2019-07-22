#!/bin/bash

list_dist () {
	find dist -type f | sed 's/\ /\\ /g' | sort
}

set -x

# Create a tarball, in a reproducible way

# shellcheck disable=SC2046
tar \
	--format=v7 \
	--mode='a+rwX,o-w' \
	--owner=0 \
	--group=0 \
	--mtime='@1560859200' \
	-cf dist.tar \
	$(list_dist) || exit 1
xz dist.tar
sha1sum dist.tar.xz
