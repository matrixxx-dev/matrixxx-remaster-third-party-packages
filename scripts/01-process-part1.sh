#!/bin/bash

## ########################################################################## ##
## process part1: determine and download packages
##
## ########################################################################## ##
## includes:
source ./part1.ini

## declaration
CALLED="$1"
export CALL="true"

## -------------------------------------------------------------------------- ##
## FUNCTIONS:
## -------------------------------------------------------------------------- ##
func_process_part1(){
  local start end period

  start=$(date +%s)         ## time measurement: start

  ## process: determine and download packages
  echo "Start: Process Part 1"
  ./part1-generate-third-party-packages-list.sh
  ./part1-get-third-party-packages.sh

  end=$(date +%s)           ## time measurement: end
  period=$((end - start))
  echo "Complete processing - elapsed time: ${period} seconds"
}

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
## Check on package directory
[ -d "${PACKAGE_DIR}" ] \
  && { read -rp "directory \"${PACKAGE_DIR}\" exists!"; exit 1; }

## process: determine and download packages
func_process_part1

## -------------------------------------------------------------------------- ##
## pause:
[ "${CALLED}" = "called" ] || { echo "Press enter to continue..."; read -r; }

## ########################################################################## ##
exit 0
