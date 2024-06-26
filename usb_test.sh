#!/bin/bash

# Identify the USB stick device (e.g., /dev/sdb1)
USB_DEVICE="/dev/sdb1"
MOUNT_POINT="/mnt/usb_stick"

# Get the directory of the current script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if the USB stick is plugged in
if lsblk | grep -q "sdb1"; then
    echo "USB stick detected."

    # Mount the USB stick
    mount "$MOUNT_POINT"

    if [ $? -eq 0 ]; then
        echo "USB stick mounted at $MOUNT_POINT."

        # Write the debug file
		bash "${SCRIPT_DIR}/passwd_status.sh" "$MOUNT_POINT/password.txt"
        echo "password information written to the USB stick."

        # Unmount the USB stick
        umount "$MOUNT_POINT"
        echo "USB stick unmounted."
    else
        echo "Failed to mount the USB stick."
    fi
else
    echo "USB stick is not plugged in."
fi
