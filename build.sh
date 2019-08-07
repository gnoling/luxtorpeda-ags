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
pushd agsteamstub || exit 1
  cp -f ../source/Engine/plugin/agsplugin.h ./
  make
popd || exit 1

wget "https://www.adventuregamestudio.co.uk/releases/finals/AGS-3.4.1-P2/AGS.3.4.1.13.Editor.Linux.Pack.zip"
unzip AGS.3.4.1.13.Editor.Linux.Pack.zip

for app_id in $STEAM_APP_ID_LIST ; do
	mkdir -p "$app_id/dist"
  cp -R Linux/lib64 Linux/ags64 Linux/licenses "$app_id/dist/"
  cp -f agsteamstub/libagsteam.so "$app_id/dist/lib64/"
done
