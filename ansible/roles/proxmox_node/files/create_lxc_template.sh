#!/bin/zsh

DEBIAN_VERSION=trixie
IMAGE_VERSION=20251109_05:24

mkdir -p /tmp/lxc_template_creation/fixed_template
cd /tmp/lxc_template_creation/

# === Download original LXC template files ===

wget https://images.linuxcontainers.org/images/debian/$DEBIAN_VERSION/arm64/default/$IMAGE_VERSION/rootfs.tar.xz
wget https://images.linuxcontainers.org/images/debian/$DEBIAN_VERSION/arm64/default/$IMAGE_VERSION/SHA256SUMS

# Verify checksum, fail if not matching
if ! sha256sum -c SHA256SUMS --ignore-missing; then
	echo "❌ Checksum verification failed — deleting LXC template" >&2
	rm -f rootfs.tar.xz
    rm -f SHA256SUMS
	exit 1
fi

rm -f SHA256SUMS

#  === Modify the template as needed ===

# We create the /etc/network/interfaces file
# Because proxmox requires this

cd fixed_template
tar -xJf ../rootfs.tar.xz
mkdir -p etc/network
cat <<EOF > etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
EOF

# Add lxc_first_launch.sh script to be run at first boot
# Unfortunetly, it must be ran manually by the user after first boot
mkdir -p usr/local/bin
cp ../lxc_first_launch.sh root/lxc_first_launch.sh
chmod +x root/lxc_first_launch.sh

# === Repack and move to Proxmox folder ===

tar -cJf ../rootfs.tar.xz *

cd ..
rm -rf fixed_template

sudo mv rootfs.tar.xz /var/lib/vz/template/cache/debian-$DEBIAN_VERSION-thomas-arm64.tar.xz

sudo chown root:root /var/lib/vz/template/cache/debian-$DEBIAN_VERSION-thomas-arm64.tar.xz
sudo chmod 644 /var/lib/vz/template/cache/debian-$DEBIAN_VERSION-thomas-arm64.tar.xz

echo " ✅ LXC template for Debian $DEBIAN_VERSION (arm64) created."
