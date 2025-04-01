sudo dnf update && dnf upgrade

echo "Instalando vscode"

if sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc; then
    echo "Importando key..."
    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo >/dev/null
else
    echo "Falha ao importar a key. Verifique a conexão ou o link!"
    exit 1
fi

sudo dnf install code

echo "Vscode instalado com sucesso"

echo "Instalando extensões do vscode"

while IFS= read -r line; do
    extension=${line#*=}
    code --install-extension ${extension%,*}
done <extensions

echo "Extensões do vscode instaladas com sucesso."

echo "Instalando google chrome"

version=${uname-m}

if wget https://dl.google.com/linux/direct/google-chrome-stable_current_${version}.rpm; then
    echo "Baixando e instalando o google chrome"
    sudo dnf install ./google-chrome-stable_current_*.rpm
    google-chrome --version
else
    echo "Falha ao baixar o google chrome. Verifique a conexão ou o link"
    exit 1
fi

echo "Google chrome instalado com sucesso"

echo "Instalando Intellij idea"

if wget -O ./ideaIC-2024.3.5.tar.gz https://download.jetbrains.com/idea/ideaIC-2024.3.5.tar.gz?_gl=1*1wmjk5v*_ga*NTYyMDgxODQ3LjE3NDM0NjMzMDI.*_ga_9J976DJZ68*MTc0MzQ2MzMwMS4xLjEuMTc0MzQ2NDA0Mi4wLjAuMA..; then
    tar -xvf ./ideaIC-2024.3.5.tar.gz
else
    echo "Falha ao baixar intellij idea community"
    exit 1
fi

shortcut="IntellijIdea.desktop"
local="~/.local/share/applications"

touch $shortcut

while IFS= read -r line; do
    printf "%s\n" "$line" >>./$shortcut
done <idea

if [ -d "${local}" ]; then
    mv ./${shortcut} ${local}
else
    echo "O diretório não existe, criando diretório..."
    mkdir ~/${local}
fi

echo "Intellij idea instalado com sucesso"

echo "Instalando warp"

if ! command -v warp &>/dev/null; then
    echo "warp não está instalado. Instalando..."
    sudo dnf install warp
else
    echo "warp já está instalado"
fi

echo "Warp instalado com seucesso"
