#!/bin/bash

# setup network interfaces
# sudo ip route del default

# install packages
sudo apt update &&
sudo apt install -y cmake gcc build-essential libx11-dev zlib1g-dev libjpeg62-turbo-dev libpixman-1-dev libfltk1.3-dev libgnutls28-dev libpam0g-dev gettext libxi-dev libxrender-dev netcat &&

# install vncviewer
cd ~ && mkdir vnc && cd vnc &&
wget https://github.com/TigerVNC/tigervnc/archive/refs/tags/v1.12.0.tar.gz -O tigervnc.tar.gz &&
tar -xf tigervnc.tar.gz &&
cd tigervnc-1.12.0/ &&
cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DINSTALL_SYSTEMD_UNITS=OFF -Wno-dev . && make && sudo make install &&
sudo chmod -R 777 /usr/local/bin/ &&
cd ~ && rm -rf vnc &&

# setup xinitrc
echo 'until nc -z 192.168.214.1 5900
do
    echo Waiting for VNC
    sleep 1
done

exec /usr/local/bin/vncviewer -FullScreen -geometry 1920x1080+0+0 -MenuKey Pause −ReconnectOnError=0 192.168.214.1' > ~/.xinitrc &&

# setup auto startx
echo 'if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec startx
fi' > ~/.bash_profile &&

# setup auto login
sudo sed -i 's/#NAutoVTs=6/NAutoVTs=1/' /etc/systemd/logind.conf &&
echo '[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin auduser --noclear %I 38400 linux' > /tmp/login_override.txt &&
sudo env SYSTEMD_EDITOR="cp /tmp/login_override.txt" systemctl edit getty@tty1 &&
rm /tmp/login_override.txt &&
sudo systemctl enable getty@tty1.service &&

# remove rule to renew password after 90 days
sudo sed -i '/^PASS_MAX_DAYS\s+90/d; /^PASS_WARN_AGE\s+80/d' /etc/login.defs

# handle display timeout
if ! grep -q 'Section "ServerFlags"' /usr/share/X11/xorg.conf.d/10-quirks.conf; then
    sudo echo 'Section "ServerFlags"
    Option "BlankTime" "240"
    Option "StandbyTime" "240"
    Option "SuspendTime" "240"
    Option "OffTime" "240"
EndSection' >> /usr/share/X11/xorg.conf.d/10-quirks.conf
fi

echo "Bitte Internetkabel aus eno1 entfernen und eno2 mit der Steuerung verbinden, danach ENTER drücken"
read

sudo reboot