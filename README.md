# Usage
On boot, a script will check for the presence of a USB stick
- When no USB stick is plugged in, the vncviewer will be opened.
- When any USB stick is plugged in, the vncviewer will not start, instead some debug information is written to the root directory of the USB stick.

# Initial Setup

Plug in boot usb stick and boot from it. In case it is not detected:
- press F2 to get into boot menu
- `c` to open the command line
- `set root=(hd0,gpt1)`
- `chainloader /efi/boot/bootx64.efi`
- `boot` and press `ENTER` to select the first option

# installing the os
- Select `Install System`
- Select `Install selected image` and confirm with `Yes!`
- Don't restore from backup config, just `Reboot`

# Configuring mel-setup
- `OK`
## Locale Settings
- `German: de_DE.UTF-8`
## Keyboard Settings
- `pc105`
- `de`
- `None`
- `No`
## Networking Settings
eno1:
- `dhcp`
- `No` obtain hostname with DHCP
eno2:
- `static`
- IP Address: `192.168.214.241`
- IP Netmask: `255.255.255.0`
- IP Gateway: `192.168.214.254`
- DNS Server: `192.168.214.254`
select `Done`, `No` proxy, `No` firewall
## Timezone Settings
- `Europe`
- `Berlin`
## Hostname Settings
- `ipc127`
## Date/Time Settings
- `NTP`
- `time.google.com`
## Active Directory Settings
- `No`
## Apt Mirror Settings
- `Add Mirror`
- `http://ftp.de.debian.org/debian/`
- `Yes`, `Yes`, `Yes`
- `Done`
## Root Settings
- `Yes`
## User Settings
- User's full name: `auduser`
- User's userid: `auduser`
- User`s password: `SUNRISE1`
- `OK`
## Apt Update Settings
- `disable`
## Optional Software Settings
- Go to `X Window`, press `ENTER`, select `install` and press `ENTER` again
- `DONE`
## Autostart Settings
- `Disable`

Wait until configuration is finished, then `Ok` and wait for reboot.

## Setup script

Either login directly or via ssh, and run the following command:
```
sudo apt install -y unzip && curl -L -o download.sh https://raw.githubusercontent.com/Tabbomat/ipc_setup/main/download.sh && bash download.sh
```
Wait until it is finished (~ 4 minutes), and confirm reboot with `y`.
