#!/bin/bash

## ########################################################################## ##
## mount squashfs loopdevice (as virtual device):
##
## ########################################################################## ##
## definitions & initializations
MOUNT_DIR="mnt"
IMAGE_ARRAY=(
)

## -------------------------------------------------------------------------- ##
## FUNCTIONS:
## -------------------------------------------------------------------------- ##
## mount a virtual device
func_mount_virtual_device(){
  local image mountpoint
  for image in "${IMAGE_ARRAY[@]}"
  do
    echo "mount image: ${image}"
    mountpoint="./${MOUNT_DIR}/${image}"
    [ -d "${mountpoint}" ] || mkdir -p "${mountpoint}"
    sudo mount  -o loop "${image}" "${mountpoint}"
  done
}

## -------------------------------------------------------------------------- ##
## MAIN:
## -------------------------------------------------------------------------- ##
func_mount_virtual_device

## -------------------------------------------------------------------------- ##
## pause:
echo "Press enter to continue..."; read -r

## ########################################################################## ##
exit 0
