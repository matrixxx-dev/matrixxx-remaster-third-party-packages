#!/bin/bash

## ########################################################################## ##
## unmount squashfs loopdevice:
##
## ########################################################################## ##
## definitions & initializations
MOUNT_DIR="mnt"

## -------------------------------------------------------------------------- ##
## FUNCTIONS:
## -------------------------------------------------------------------------- ##
## unmount a virtual device
func_umount_virtual_device(){
  local dir_list dir image_array device
  readarray -t dir_list < <(ls "${MOUNT_DIR}" 2>/dev/null)
  image_array=()
  for dir in "${dir_list[@]}"
  do
    readarray -t image_array < <(lsblk | grep "${dir}" 2>/dev/null)
    for device in "${image_array[@]}"
    do
      device="/dev/${device// */}"
      echo "umount device: ${device} on"
      lsblk -o MOUNTPOINTS -n "${device}"
      sudo umount "${device}"
    done
  done

  [ -d "${MOUNT_DIR}" ] && { echo "delete: ${MOUNT_DIR}"; rm -rf "${MOUNT_DIR}"; }
}

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
func_umount_virtual_device

## -------------------------------------------------------------------------- ##
## pause:
echo "Press enter to continue..."; read -r

## ########################################################################## ##
exit 0
