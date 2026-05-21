#!/bin/bash

## ########################################################################## ##
## process part2: build layer files for amd64 and i386 OS
## - extract packages to working directory
## - build squashfs file
##
## ToDo: Erzeuge im /opt Verzeichnis für alle versionierten Verzeichnisse
##       einen Symlink auf ein neutrales Verzeichnis
## ########################################################################## ##
## includes:
source ./part2.ini

## declaration
CALLED="$1"
CALL="true"

## -------------------------------------------------------------------------- ##
## FUNCTIONS:
## -------------------------------------------------------------------------- ##
func_process_part2(){
  local start end period
  local arch

  start=$(date +%s)         ## time measurement: start

  ## process: extract packages to working directory and build squashfs file
  echo "Start: Process Part 2"

  ## architecture: "amd64"
  arch="amd64"
  ./part2-Xtract-packages.sh "${arch}" "${CALL}"
  ./part2-Xtract-generate-squashfs.sh "${LAYER_DIR}/${arch}" "${CALL}"
  [ -d "${TEMP_COLLECTION_DIR}" ] && [ "${arch}" = "amd64" ] && {
    echo "change ${TEMP_COLLECTION_DIR} to ${TEMP_COLLECTION_DIR}-64 (${arch})"
    mv "${TEMP_COLLECTION_DIR}" "${TEMP_COLLECTION_DIR}-64"
  }

  ## architecture: "i386"
  arch="i386"
  ./part2-Xtract-packages.sh "${arch}" "${CALL}"
  ./part2-Xtract-generate-squashfs.sh "${LAYER_DIR}/${arch}" "${CALL}"

  end=$(date +%s)           ## time measurement: end
  period=$((end - start))
  echo "Complete processing - elapsed time: ${period} seconds"
}

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
## Check on package directory
[ -d "${PACKAGE_DIR}" ] \
  || { read -rp "missing \"${PACKAGE_DIR} directory!\""; exit 1; }

## Check on collection directories
[ -d "${TEMP_COLLECTION_DIR}" ] || [ -d "${TEMP_COLLECTION_DIR}-64" ] \
    && { read -rp "directory \"${TEMP_COLLECTION_DIR}\" or \"-64\" exist!"; exit 1; }

### generate Layer for 32 & 64 bit OS
func_process_part2

## -------------------------------------------------------------------------- ##
## pause:
[ "${CALLED}" = "called" ] || { echo "Press enter to continue..."; read -r; }

## ########################################################################## ##
exit 0
