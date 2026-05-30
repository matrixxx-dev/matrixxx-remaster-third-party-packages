#!/bin/bash

## ########################################################################## ##
## Extract packages in a corresponding data directory
##
## ########################################################################## ##
## start script with sudo:
[ "$(id -u)" != "0" ] && exec sudo "$0" "$@"

## includes:
source ./part2.ini

## declaration
ARCH="$1"
if [ "${ARCH}" = "i386" ]; then
  DATA_DIR_LIST=("data" "data_i386")
elif [ "${ARCH}" = "amd64" ]; then
  DATA_DIR_LIST=("data" "data_amd64")
else
  echo "no valid architecture chosen"
  echo "Press enter to continue..."; read -r
  exit
fi

## init the 'callee' handling
[ -z "$2" ] && { echo "$(basename "$0") is a callee!!!"; read -r; exit 1; }
if [ "$2" = "true" ]; then
  CALLED="$2"
else
  CALLED="false"
fi

## -------------------------------------------------------------------------- ##
## FUNCTIONS:
## -------------------------------------------------------------------------- ##
func_extract_packages_process(){
  for WORKING_DIR in "${WORKING_DIR_LIST[@]}"
  do
    echo "*** Processed directory: ${WORKING_DIR} ***"
    func_read_package_file
  done
}

func_read_package_file(){
  local element package_path package_dir
  for element in "${DATA_DIR_LIST[@]}"
  do
    package_path="${WORKING_DIR}/${element}"
    [ -f "${package_path}/${PACKAGE_FILE}" ] || {
      echo "- ${package_path}/${PACKAGE_FILE} not found"
      continue
    }
    source "${package_path}/${PACKAGE_FILE}"
    for package_dir in "${package[@]}"
    do
      func_change_to_package_directory "${package_path}" "${package_dir}"
    done
  done
}

func_change_to_package_directory (){ # package_path package_dir
  local package_path package_dir
  package_path="$1"; package_dir="$2"
  cd "${package_path}/${package_dir}" || return 1
  func_extract_package_to_data "${package_dir}"
  cd "${SCRIPT_PATH}" || return 1
}

func_extract_package_to_data() # dir_name
{
  ## declarations
  local dir_name info_file file_ext file_list file output output_path
  dir_name="$1"
  file_ext="${dir_name#*.}"
  output="${OUTPUT_PATH}"
  info_file="${output}/info/${dir_name}.txt"
  file_list=$(find ./ -type f -name \*."${file_ext}" -exec basename {} ';')

  echo "-> ${dir_name}:"
  if [ -z "${file_list}" ]
  then
    echo "  ... is not a .${file_ext} package"
  else
    [ -d "${output}" ] || mkdir -p "${output}"/info
    sh -c "echo 'CONTENT:' > ${info_file}"
    for file in ${file_list}; do
      echo "Extracted file: ${file}"
      sh -c "echo ' '${file} >> ${info_file}"

      if [ "${file_ext}" = "tgz" ] || [ "${file_ext}" = "tar.xz" ] \
        || [ "${file_ext}" = "zip" ] ; then
        mkdir -p "${output}/opt"
        output_path="${output}/opt"
      else
        output_path="${output}"
      fi

      func_extract_package "${file}" "${output_path}" "${file_ext}"
    done
  fi
}

func_extract_package() # file output type
{
  local file output type
  file="$1"; output="$2"; type="$3"

  if [ "${type}" = "deb" ]; then
    dpkg -x "${file}" "${output}"
  fi
  if [ "${type}" = "tar.gz" ]; then
    tar -zxf "${file}" -C "${output}"
  fi
  if [ "${type}" = "tgz" ]; then
    tar -zxf "${file}" -C "${output}"
  fi
  if [ "${type}" = "tar.xz" ]; then
    tar -Jxf "${file}" -C "${output}" #--strip-components=1
  fi
  if [ "${type}" = "zip" ]; then
    unzip "${file}" -d "${output}"
  fi
  if [ "${file_ext}" = "tgz" ] || [ "${file_ext}" = "tar.xz" ] \
    || [ "${file_ext}" = "zip" ] ;
  then
    [ "${SET_USER_RIGHTS_FOR_OPT}" = "true" ] \
      && chown -fR 1000:1000 "${output}"/*
  fi
}

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
func_extract_packages_process

## -------------------------------------------------------------------------- ##
## pause:
[ "${CALLED}" = "true" ] || { echo "Press enter to continue..."; read -r; }

## ########################################################################## ##
exit 0
