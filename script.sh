#!/bin/bash

sudo dnf update -y && sudo dnf upgrade -y

if sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc; then
    echo "Importando key..."
    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo >/dev/null
else
    echo "Falha ao importar a key. Verifique a conexão ou o link!"
    exit 1
fi

sudo dnf install -y code

while IFS= read -r line; do
    extension=${line#*=}
    code --install-extension "${extension%,*}"
done < extensions

version=$(uname -m)

if wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_${version}.rpm; then
    echo "Baixando e instalando o google chrome"
    sudo dnf install -y ./google-chrome-stable_current_*.rpm
    google-chrome --version
else
    echo "Falha ao baixar o google chrome. Verifique a conexão ou o link"
    exit 1
fi

if wget -q -O ./ideaIC-2024.3.5.tar.gz https://download.jetbrains.com/idea/ideaIC-2024.3.5.tar.gz?_gl=1*1wmjk5v*_ga*NTYyMDgxODQ3LjE3NDM0NjMzMDI.*_ga_9J976DJZ68*MTc0MzQ2MzMwMS4xLjEuMTc0MzQ2NDA0Mi4wLjAuMA..; then
    tar -xvf ./ideaIC-2024.3.5.tar.gz
else
    echo "Falha ao baixar IntelliJ IDEA Community"
    exit 1
fi

shortcut="IntellijIdea.desktop"
local="$HOME/.local/share/applications"

touch "$shortcut"

while IFS= read -r line; do
    printf "%s\n" "${line//\$HOME/$HOME}" >> "$shortcut"
done < idea

if [ ! -d "${local}" ]; then
    echo "Diretório não existe, criando diretório..."
    mkdir -p "${local}"
fi

mv ./"$shortcut" "${local}"

if ! command -v warp &>/dev/null; then
    echo "warp não está instalado. Instalando..."
    sudo dnf install -y warp
else
    echo "warp já está instalado"
fi
