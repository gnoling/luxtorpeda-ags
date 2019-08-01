#!/bin/bash

source env.sh

set -x

# Create a tarball, in a reproducible way

for app_id in $STEAM_APP_ID_LIST ; do
	pushd "$app_id" || exit 1
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
	popd || exit 1
done
