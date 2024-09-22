# Installing Qemu on Artix(runit)

- install the packages

sudo pacman -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat libvirt libvirt-runit libguestfs

- enable the services

sudo ln -s /etc/runit/sv/libvirtd /run/runit/service
sudo ln -s /etc/runit/sv/virtlogd /run/runit/service/

- sudo vim /etc/libvirt/libvirtd.conf Uncomment The Following Lines:

unix_sock_group = "libvirt"
unix_sock_ro_perms = "0777"
unix_sock_rw_perms = "0770"

Write/Quit out of file.

- Add current user to libvirt group:

sudo usermod -a -G libvirt $(whoami)

- reboot.

sudo virsh net-start default

sudo virsh net-autostart default

sudo virsh net-list --all

