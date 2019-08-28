#!/bin/sh

# Hack my damn network!
rm -f /etc/resolv.conf
echo "nameserver 1.1.1.1" > /etc/resolv.conf

echo "deb http://repo.ubports.com/ xenial_-_edge_-_mesa main" >> /etc/apt/sources.list.d/ubports.list
echo "deb http://repo.ubports.com/ xenial_-_edge_-_pine main" >> /etc/apt/sources.list.d/ubports.list

echo "" >> /etc/apt/preferences.d/ubports.pref
echo "Package: *" >> /etc/apt/preferences.d/ubports.pref
echo "Pin: origin repo.ubports.com" >> /etc/apt/preferences.d/ubports.pref
echo "Pin: release o=UBports,a=xenial_-_edge_-_mesa" >> /etc/apt/preferences.d/ubports.pref
echo "Pin-Priority: 2000" >> /etc/apt/preferences.d/ubports.pref

echo "" >> /etc/apt/preferences.d/ubports.pref
echo "Package: *" >> /etc/apt/preferences.d/ubports.pref
echo "Pin: origin repo.ubports.com" >> /etc/apt/preferences.d/ubports.pref
echo "Pin: release o=UBports,a=xenial_-_edge_-_pine" >> /etc/apt/preferences.d/ubports.pref
echo "Pin-Priority: 2000" >> /etc/apt/preferences.d/ubports.pref

apt update
apt upgrade -y --allow-downgrades
apt autoremove -y

apt install ubuntu-touch-session-wayland -y

# Add mesa ld conf since latest does not provide this
DEB_HOST_MULTIARCH="aarch64-linux-gnu"
echo "/usr/lib/$DEB_HOST_MULTIARCH/mesa-egl" > /usr/lib/$DEB_HOST_MULTIARCH/mesa-egl/ld.so.conf
update-alternatives --set $DEB_HOST_MULTIARCH"_egl_conf" /usr/lib/$DEB_HOST_MULTIARCH/mesa-egl/ld.so.conf