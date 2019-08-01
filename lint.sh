#!/bin/bash
set -x
shellcheck ./*.sh
pylint "bootstrap/start.py"
