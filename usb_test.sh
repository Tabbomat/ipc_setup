#!/bin/bash

# Identify the USB stick device (e.g., /dev/sdb1)
USB_DEVICE="/dev/sdb1"
MOUNT_POINT="/mnt/usb_stick"

# Check if the USB stick is plugged in
if lsblk | grep -q "sdb1"; then
    echo "USB stick detected."

    # Create a mount point if it doesn't exist
    [ ! -d "$MOUNT_POINT" ] && sudo mkdir -p "$MOUNT_POINT"

    # Mount the USB stick
    sudo mount "$USB_DEVICE" "$MOUNT_POINT"

    if [ $? -eq 0 ]; then
        echo "USB stick mounted at $MOUNT_POINT."

        # Write the debug file
		bash ~/ipc_setup-main/passwd_status.sh "$MOUNT_POINT/password.txt"
        echo "password information written to the USB stick."

        # Unmount the USB stick
        sudo umount "$MOUNT_POINT"
        echo "USB stick unmounted."

        # Clean up
        [ -d "$MOUNT_POINT" ] && sudo rmdir "$MOUNT_POINT"
    else
        echo "Failed to mount the USB stick."
    fi
else
    echo "USB stick is not plugged in."
fi
