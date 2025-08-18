#!/bin/bash

# QEMU + libvirt setup on Artix (runit)
# Run this script as root or with sudo

set -e  # Exit on error

POST_REBOOT_FILE="$HOME/qemu-post-reboot.txt"

echo "==> Installing packages..."
sudo pacman -S --needed --noconfirm qemu-desktop virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat libvirt libvirt-runit libguestfs

echo "==> Enabling runit services for libvirtd and virtlogd..."
sudo ln -sf /etc/runit/sv/libvirtd /run/runit/service
sudo ln -sf /etc/runit/sv/virtlogd /run/runit/service

echo "==> Configuring /etc/libvirt/libvirtd.conf..."
sudo sed -i \
  -e 's/^#unix_sock_group = "libvirt"/unix_sock_group = "libvirt"/' \
  -e 's/^#unix_sock_ro_perms = "0777"/unix_sock_ro_perms = "0777"/' \
  -e 's/^#unix_sock_rw_perms = "0770"/unix_sock_rw_perms = "0770"/' \
  /etc/libvirt/libvirtd.conf

echo "==> Adding user $(whoami) to libvirt group..."
sudo usermod -a -G libvirt $(whoami)

echo
echo "!! IMPORTANT: You must reboot for group membership changes to take effect !!"
echo "Reboot now? (y/n): "
read REBOOT_CHOICE

echo "==> Writing post-reboot instructions to $POST_REBOOT_FILE"
cat << EOF > "$POST_REBOOT_FILE"
After reboot, run the following commands to activate libvirt networking:

    sudo virsh net-start default
    sudo virsh net-autostart default
    sudo virsh net-list --all
EOF

if [[ "$REBOOT_CHOICE" =~ ^[Yy]$ ]]; then
    echo "==> Rebooting..."
    reboot
else
    echo "==> Skipping reboot. Instructions saved to $POST_REBOOT_FILE"
    cat "$POST_REBOOT_FILE"
fi

