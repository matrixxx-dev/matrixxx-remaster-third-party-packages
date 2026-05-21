#!/bin/bash

## ########################################################################## ##
## generate squashfs
##
##
## ########################################################################## ##
## includes:
source ./part2.ini
source ../lib/func_mk-squashfs-image-handling

## declaration
SAVE_DIR="$1"

if [ "$2" = "true" ]; then
  CALLED="$2"
else
  CALLED="false"
fi

INPUT_PATH="${OUTPUT_PATH}"

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
[ -d "${SAVE_DIR}" ] || mkdir -p "${SAVE_DIR}"
func_mk_squashfs_image "${INPUT_PATH}" "${SAVE_DIR}/LAYER${LAYER_NO}"


## -------------------------------------------------------------------------- ##
## pause:
[ "${CALLED}" = "true" ] || { echo "Press enter to continue..."; read -r; }

## ########################################################################## ##
exit 0
