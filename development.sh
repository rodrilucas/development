#!/bin/bash

set -e

sudo dnf update && upgrade -y

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc || exit 1
echo "Importando key..."
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo >/dev/null

sudo dnf install -y code

while IFS= read -r line; do
    extension=${line#*=}
    code --install-extension "${extension%,*}"
done <extensions

version=$(uname -m)

wget https://dl.google.com/linux/direct/google-chrome-stable_current_${version}.rpm || exit 1
sudo dnf install -y ./google-chrome-stable_current_*.rpm
google-chrome --version

wget -O ./ideaIC-2024.3.5.tar.gz "https://download.jetbrains.com/idea/ideaIC-2024.3.5.tar.gz?_gl=1*1wmjk5v*_ga*NTYyMDgxODQ3LjE3NDM0NjMzMDI.*_ga_9J976DJZ68*MTc0MzQ2MzMwMS4xLjEuMTc0MzQ2NDA0Mi4wLjAuMA.." || exit 1
tar -xvf ./ideaIC-2024.3.5.tar.gz

shortcut="IntellijIdea.desktop"
local="$HOME/.local/share/applications"

touch "$shortcut"

while IFS= read -r line; do
    printf "%s\n" "${line//\$HOME/$HOME}" >>"$shortcut"
done <idea

mkdir -p "$local"
mv ./$shortcut "$local"

APPS=(
    "rest.insomnia.Insomnia"
)

command -v flatpak &>/dev/null || sudo dnf install -y flatpak
flatpak remote-list | grep -q "flathub" || flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

for APP in "${APPS[@]}"; do
    flatpak install -y flathub "$APP"
done

if ! command -v docker &>/dev/null; then
    sudo dnf -y install dnf-plugins-core
    sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo || exit 1
    sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi

sudo systemctl enable --now docker