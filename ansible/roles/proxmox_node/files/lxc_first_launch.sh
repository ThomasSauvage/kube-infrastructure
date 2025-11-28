#!/bin/bash

# Install ssh server to allow setup with Ansible

apt update
apt install openssh-server -y

# Install ifupdown2 to manage network interfaces via /etc/network/interfaces
# Do this as a last thing as it breaks network until reboot

apt install ifupdown2 -y

systemctl disable systemd-networkd
systemctl stop systemd-networkd

echo "✅ Consider rebooting the system to apply changes."