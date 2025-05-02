#!/bin/bash

sudo pacman -Syu firefox gnome-extra gnome-tweaks gnome-control-center gdm gnome-shell gnome-backgrounds gnome-settings-daemon gnome-session gnome-terminal gnome-system-monitor gnome-disk-utility gnome-calculator gnome-characters gnome-contacts gnome-font-viewer gnome-logs gnome-menus gnome-screenshot gnome-shell-extensions gnome-themes-extra gvfs gvfs-mtp gvfs-nfs gvfs-smb nautilus networkmanager xdg-user-dirs xdg-utils gnome-power-manager git zoxide bluez bluez-utils pipewire pipewire-pulse pipewire-alsa wireplumber python-pipx wl-clipboard ffmpeg gstreamer gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav gstreamer-vaapi base-devel cmake ninja curl tmux jq gtk4 libadwaita blueprint-compiler gettext power-profiles-daemon hyprland brightnessctl fzf wofi ninja gcc wayland-protocols libjpeg-turbo libwebp libjxl pango cairo pkgconf cmake libglvnd wayland hyprutils hyprwayland-scanner hyprlang hyprpaper xdg-desktop-portal-hyprland qt5-wayland qt6-wayland blueman waybar fzf brightnessctl keepassxc ntfs-3g exfatprogs bat

gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
gsettings set org.gnome.shell disable-user-extensions false

sudo systemctl enable --now bluetooth.service
sudo systemctl --user enable --now pipewire pipewire-pulse wireplumber
sudo systemctl enable --now power-profiles-daemon

mkdir ~/source
cd ~/source
git clone https://aur.archlinux.org/widevine.git
cd widevine
makepkg -si

cd ~/source
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay -S visual-studio-code-bin
