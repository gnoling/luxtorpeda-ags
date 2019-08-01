#!/bin/bash

source env.sh

set -x
set -e

log_environment
prepare_manifest_files "$STEAM_APP_ID_LIST"

# build instructions
#
# write build instructions here
# place resulting binaries in directories: '<app_id>/dist'
#
pushd source || exit 0
