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