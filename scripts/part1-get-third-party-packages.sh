#!/bin/bash

## ########################################################################## ##
## Get third party packages
## input: [data*.list]
## - download packages and generate ./data directories
## ########################################################################## ##
## includes:
source ./part1.ini

## declaration
LOG_FILE="download_package.log"
DOWNLOAD_FILE="download.list"

## -------------------------------------------------------------------------- ##
## FUNCTIONS:
## -------------------------------------------------------------------------- ##
func_init_package_structure(){
  local dir
  for dir in ${DATA_DIR_LIST}; do
    [ -d "${dir}" ] && rm -rf "${dir}"
    mkdir -p "${dir}"
    echo "local package=(" > "${dir}/${PACKAGE_FILE}"
    echo -n > "${dir}/${DOWNLOAD_FILE}"
  done
}

func_download_files(){
  local data_dir download_list element i dir file url
  for data_dir in ${DATA_DIR_LIST}; do
    file="${data_dir}.list"
    [ -f "${file}" ] && readarray download_list < "${file}"
    for element in "${download_list[@]}"
    do
      typeset -i i; i=0
      for part in ${element}; do
        [[ $i -eq 0 ]] && { file="${part}"; dir=$(dirname "${part}"); }
        [[ $i -eq 1 ]] && url="${part}"
        (( i+=1 ))
      done
      if [ ! -d "${dir}" ]; then
        mkdir -p "${dir}"
        basename "${dir}" >> "${data_dir}/${PACKAGE_FILE}"
      fi
      echo "download: ${url}"
      wget -a "${LOG_FILE}" -O "${file}" "${url}" \
        && { echo "${url}" >> "${data_dir}/${DOWNLOAD_FILE}"; }
    done
  done

  ## finish package structure files
  for dir in ${DATA_DIR_LIST}; do
    echo ")" >> "${dir}/${PACKAGE_FILE}"
  done
}

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
  ## -----------------------
  ## time measurement: start
  main_start=$(date +%s)
  ## -----------------------
  echo "-- Get the files from the 'download.list' files:"

  cd "${PACKAGE_DIR}" \
    || { echo "${PACKAGE_DIR} does not exist!"; read -r; exit 1; }

  func_init_package_structure
  func_download_files

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
