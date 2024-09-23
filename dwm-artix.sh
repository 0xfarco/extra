#!/bin/bash

echo "Installing Dependencies"

sudo pacman -S xorg-server xorg-xinit xf86-video-nouveau \
libx11 libxft libxinerama \
xorg-xrandr xorg-xwininfo base-devel \
polkit sxhkd alacritty rofi feh dunst picom github-cli\
tlp tlp-runit tlp-rdw thermald thermald-runit lm_sensors lm_sensors-runit \
trizen dosfstools libnotify calcurse exfat-utils firefox\
nsxiv flameshot ffmpeg ffmpegthumbnailer \
neovim vim nano mpv vlc pcmanfm qbittorrent\
cronie cronie-runit \
docker docker-runit freerdp remmina libqalculate qalculate-qt \
neomutt curl wget isync msmtp pass ca-certificates gettext lynx notmuch \
man-db ntfs-3g xclip copyq zathura zathura-pdf-mupdf \
fzf mediainfo brightnessctl htop slock xautolock imlib2 moreutils \
pipewire wireplumber pipewire-pulse pulsemixer \
newsboat tesseract tesseract-data-eng \
libertinus-font ttf-font-awesome ttf-jetbrains-mono-nerd ttf-dejavu noto-fonts noto-fonts-emoji

echo "Downloading and Installing Configuration files"

cd $HOME

git clone https://github.com/autocraticbinary/dotfiles

mkdir Pictures Public Documents
mkdir -p $HOME/.local/bin

cd $HOME/dotfiles
tail .xinitrc -n 3 >> ~/.xinitrc
tail .bash_profile -n 11 >> ~/.bash_profile
cp -r .dwm ~
cp .tmux.conf ~
cp .vimrc ~
sudo cp 30-touchpad.conf /etc/X11/xorg.conf.d/
cp -r wallpaper $HOME/Pictures

cd config
cp -r alacritty dunst picom lf rofi sxhkd $HOME/.config

cd scripts
cp -r * $HOME/.local/bin

cd $HOME/.config/alacritty
alacritty migrate

mkdir -p $HOME/.config
cd $HOME/.config
git clone https://github.com/autocraticbinary/suckless

cd $HOME/.config/suckless/dwm
sudo make clean install

cd ../dmenu
sudo make clean install

cd ../dwmblocks
sudo make clean install

echo "Creating Login Manager Entry for DWM"

sudo mkdir -p /usr/share/xsessions
cd /usr/share/xsessions
sudo touch dwm.desktop
sudo chown $USER dwm.desktop
sudo cat > dwm.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=Dwm
Comment=the dynamic window manager
Exec=dwm
Icon=dwm
Type=XSession

EOF

echo "Installing yay"

mkdir -p $HOME/Public/apps

sudo pacman -S --needed git base-devel \
&& git clone https://aur.archlinux.org/yay-bin.git \
&& cd yay-bin && makepkg -si

echo "Installing packages from AUR (yay)"

yay -S brave-bin librewolf-bin arkenfox-user.js-git lf-bin ueberzugpp\
mutt-wizard simple-mtpfs pam-gnupg abook urlview mpop


sudo ln -s /etc/runit/sv/tlp /run/runit/service/
sudo tlp start

sudo ln -s /etc/runit/thermald /run/runit/service/
sudo ln -s /etc/runit/docker /run/runit/service/
sudo ln -s /etc/runit/cronie /run/runit/service/
