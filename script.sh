sudo dnf update && dnf upgrade

if sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc; then
    echo "Importando key..."
    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo >/dev/null
else
    echo "Falha ao importar a key. Verifique a conexão ou o link!"
fi

sudo dnf install code

echo "Instalando extensões do vscode"

while IFS= read -r line; do
    extension=${line#*=}
    code --install-extension ${extension%,*}
done <extensions

echo "Extensões do vscode instaladas com sucesso."

echo "Instalando google chrome"

version=${uname -m}

if wget https://dl.google.com/linux/direct/google-chrome-stable_current_${version}.rpm; then
    echo "Baixando e instalando o google chrome"
    sudo dnf install ./google-chrome-stable_current_*.rpm
    google-chrome --version
else
    echo "Falha ao baixar o google chrome. Verifique a conexão ou o link"
fi

echo "Google chrome instalado com sucesso"
