#!/bin/bash

log_environment () {
	pwd
	nproc
	gcc --version
}

prepare_manifest_files () {
	for app_id in $1 ; do
		mkdir -p "$app_id/dist"
		touch "$app_id/dist/manifest"
	done
}

list_dist () {
	{
		find dist -type f
		find dist -type l
	} | sed 's/\ /\\ /g' | sort
}
