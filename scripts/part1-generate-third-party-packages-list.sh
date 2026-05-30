#!/bin/bash

## ########################################################################## ##
## get third party packages
## - try to get information for download from homepage
## - generate a list of donloaded versions
## - generate a list for wget to download files [data*.list]
## ########################################################################## ##
## includes:
source ./part1.ini
source ../lib/func_packages-handling
source ../func_packages

## declaration
LOG_FILE="download_info.log"
TIMESTAMP_FILE="download.time"

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
  ## -----------------------
  ## time measurement: start
  main_start=$(date +%s)
  ## -----------------------
  echo "-- Generate 'download.list' files:"
  [ -d "${PACKAGE_DIR}" ] || mkdir -p "${PACKAGE_DIR}"

  ## --------------------------
  cd "${PACKAGE_DIR}" || exit 1

  ## get the packages
  func_load_software_package

  ## generate log files with time stamps
  func_gen_log_files

  ## delete temp. download file
  func_remove_tmp_download_file

  ## -----------------------
  ## time measurement: end
  main_end=$(date +%s)
  period=$((main_end - main_start))
  ## -----------------------
  echo "Processing - elapsed time: ${period} seconds" | tee -a "${LOG_FILE}"

## -------------------------------------------------------------------------- ##
## pause:
[ "${CALL}" = "true" ] || { echo "Press enter to continue..."; read -r; }

## ########################################################################## ##
exit 0
