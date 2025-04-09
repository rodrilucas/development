# **Script de Instalação de Ambiente de Desenvolvimento**

Este script automatiza a instalação e configuração de ferramentas e programas essenciais para um ambiente de desenvolvimento no Linux, incluindo o Visual Studio Code, extensões para o Visual Studio Code, Google Chrome, IntelliJ IDEA, Insomnia e Docker.

### **Funcionalidades do Script**
1. **Atualização do Sistema**: Atualiza e faz o upgrade de pacotes do sistema.
2. **Instalação do Visual Studio Code**: Baixa e instala o VSCode, além de instalar as extensões de desenvolvimento listadas.
3. **Instalação do Google Chrome**: Baixa e instala a versão mais recente do Google Chrome.
4. **Instalação do IntelliJ IDEA Community Edition**: Baixa e instala a versão mais recente do IntelliJ IDEA Community Edition.
6. **Instalação do Insomnia**: Verifica se o insomnia está instalado e, caso não, realiza a instalação através do flathub.
5. **Instalação do Docker**: Verifica se o docker está instalado e, caso não, realiza a instalação.

### **Pré-requisitos**
- Sistema operacional baseado em **Fedora**.
- Acesso à internet para baixar pacotes e arquivos.
- Privilégios de **superusuário (sudo)** para instalar pacotes.

### **Instruções de Uso**

1. **Clone ou baixe o script**:
   Baixe ou clone o repositório seu diretório de trabalho:

    ```bash
    git clone git@github.com:rodrigzlucas/development

2. **Dê a permissão para o script**:

     ```bash
   chmod +x script.sh

3. **Execute o script**:

     ```bash
     ./script.sh

### **Alterações e Melhorias**

Se desejar personalizar o script para outro ambiente, altere os seguintes parâmetros:

- **Extensões do VSCode**: O arquivo `extensions` deve conter as extensões desejadas no formato `nome=ID_da_extensao`.
  
- **Versões de software**: O script atualmente instala versões específicas do IntelliJ IDEA e Google Chrome. Para usar versões diferentes, basta modificar os links de download.
