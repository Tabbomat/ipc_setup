#!/bin/bash

# Variables for USB device and mount point
USB_DEVICE="/dev/sdb1"
MOUNT_POINT="/mnt/usb_stick"

# Ensure mount point directory exists
if [ ! -d "$MOUNT_POINT" ]; then
    sudo mkdir -p "$MOUNT_POINT"
fi

# Set appropriate permissions and ownership for the mount point
sudo chown $(whoami):$(whoami) "$MOUNT_POINT"
sudo chmod 777 "$MOUNT_POINT"

# Check if /etc/fstab modification is needed
if ! grep -q "$USB_DEVICE" /etc/fstab; then
    # Append entry to /etc/fstab
    echo "$USB_DEVICE $MOUNT_POINT auto user,rw,noauto 0 0" | sudo tee -a /etc/fstab > /dev/null

    if [ $? -eq 0 ]; then
        echo "Entry added to /etc/fstab."
    else
        echo "Failed to add entry to /etc/fstab."
    fi
else
    echo "Entry already exists in /etc/fstab."
fi