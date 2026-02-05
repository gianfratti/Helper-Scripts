# File Browser Installation

Script automatizado para instalação do File Browser, um gerenciador de arquivos web-based moderno e simples.

## 📝 Descrição

**File Browser** é um gerenciador de arquivos web que permite navegar, fazer upload, download, editar e gerenciar arquivos do seu servidor através de uma interface web moderna e intuitiva.

Recursos principais:
- 📁 Navegação de arquivos e pastas
- ⬆️ Upload e download de arquivos
- ✏️ Editor de texto integrado
- 🔍 Busca de arquivos
- 🗄️ Pré-visualização de imagens e víde

os
- 🗑️ Operações de arquivo (copiar, mover, deletar)
- 🔐 Gerenciamento de usuários e permissões
- 🎨 Interface moderna e responsiva
- 🚀 Leve e rápido

## ⚙️ O que o script faz

1. Detecta automaticamente o sistema operacional
2. Instala dependências necessárias
3. Baixa e instala o File Browser
4. Cria estrutura de diretórios
5. Configura o File Browser (porta 8080, root /srv)
6. Inicializa banco de dados
7. Cria usuário admin padrão
8. Cria serviço systemd
9. Inicia e habilita o serviço
10. Exibe informações de acesso

## 🚀 Como usar

### Instalação básica

```bash
# Clone o repositório
git clone https://github.com/gianfratti/Helper-Scripts.git
cd Helper-Scripts/management/filebrowser

# Execute o script
sudo bash install.sh
```

### Instalação direta (sem clone)

```bash
curl -fsSL https://raw.githubusercontent.com/gianfratti/Helper-Scripts/main/management/filebrowser/install.sh | sudo bash
```

## ✅ Requisitos

- Ubuntu 20.04+ ou Debian 10+
- Privilégios de root/sudo
- Conexão com a internet
- Porta 8080 disponível

## 📊 Sistemas testados

- Ubuntu 20.04 LTS
- Ubuntu 22.04 LTS
- Ubuntu 24.04 LTS
- Debian 11 (Bullseye)
- Debian 12 (Bookworm)

## 🌐 Acesso ao File Browser

### URL de acesso

Após a instalação, acesse:

```
http://<seu-ip>:8080
```

Ou se estiver no próprio servidor:

```
http://localhost:8080
```

### Credenciais padrão

- **Usuário:** admin
- **Senha:** admin

> ⚠️ **IMPORTANTE**: Altere a senha padrão imediatamente após o primeiro login!

### Alterar senha

1. Faça login com as credenciais padrão
2. Clique no ícone do usuário (canto superior direito)
3. Vá em **Settings** → **User Management**
4. Clique em **Edit** no usuário admin
5. Altere a senha e salve

## 🔧 Configuração

### Arquivos de configuração

- **Configuração:** `/etc/filebrowser/config.json`
- **Banco de dados:** `/var/lib/filebrowser/filebrowser.db`
- **Diretório raiz:** `/srv` (arquivos que aparecem no File Browser)

### Verificar status do serviço

```bash
# Ver status
sudo systemctl status filebrowser

# Parar serviço
sudo systemctl stop filebrowser

# Iniciar serviço
sudo systemctl start filebrowser

# Reiniciar serviço
sudo systemctl restart filebrowser
```

### Mudar porta

Edite o arquivo de configuração:

```bash
sudo nano /etc/filebrowser/config.json
```

Altere a linha `"port": 8080` para a porta desejada.

Reinicie o serviço:

```bash
sudo systemctl restart filebrowser
```

### Mudar diretório raiz

Para alterar qual diretório o File Browser gerencia:

```bash
# Editar configuração
sudo nano /etc/filebrowser/config.json
```

Altere `"root": "/srv"` para o diretório desejado (ex: `"/home"`).

Reinicie:

```bash
sudo systemctl restart filebrowser
```

### Configurar firewall (UFW)

```bash
sudo ufw allow 8080/tcp
sudo ufw reload
```

## 👥 Gerenciamento de Usuários

### Via interface web

1. Login como admin
2. Settings → User Management
3. Add User ou Edit existente

### Via linha de comando

```bash
# Adicionar usuário
sudo filebrowser users add nome senha --config /etc/filebrowser/config.json

# Listar usuários
sudo filebrowser users ls --config /etc/filebrowser/config.json

# Remover usuário
sudo filebrowser users rm nome --config /etc/filebrowser/config.json

# Tornar usuário admin
sudo filebrowser users update nome --perm.admin --config /etc/filebrowser/config.json
```

## 📖 Funcionalidades

### Navegação
- Navegue por pastas clicando nelas
- Use a barra de navegação superior para voltar
- Clique com botão direito para opções

### Upload de arquivos
- Arraste e solte arquivos na interface
- Ou clique no botão Upload (canto superior direito)
- Suporta múltiplos arquivos e pastas

### Download
- Clique no arquivo para visualizar/baixar
- Selecione múltiplos arquivos e clique em Download
- Baixa como .zip quando múltiplos arquivos

### Editar arquivos
- Clique no arquivo de texto
- Botão Edit (canto superior direito)
- Editor de código com syntax highlighting

### Operações de arquivo
- Copiar/Mover: Selecione → Copy/Cut → Navegue → Paste
- Deletar: Selecione → Delete
- Renomear: Botão direito → Rename
- Nova pasta: Botão direito → New Folder

### Busca
- Use o campo de busca no topo
- Busca por nome de arquivo
- Suporta wildcards

## ⚠️ Troubleshooting

### Erro: "Porta 8080 já em uso"

```bash
# Verificar o que está usando a porta
sudo netstat -tulpn | grep 8080

# Alterar porta no File Browser (veja seção Configuração)
```

### Erro: "Não consigo acessar via navegador"

Verifique:

1. Serviço rodando: `sudo systemctl status filebrowser`
2. Firewall: `sudo ufw status`
3. Use **http://** (não https://)

### Erro: "Permission denied" ao acessar arquivos

Verifique permissões do diretório raiz:

```bash
sudo chmod -R 755 /srv
```

### Resetar senha do admin

```bash
# Parar serviço
sudo systemctl stop filebrowser

# Resetar senha
sudo filebrowser users update admin --password novasenha --config /etc/filebrowser/config.json

# Iniciar serviço
sudo systemctl start filebrowser
```

## 🔄 Atualizar File Browser

```bash
# Parar serviço
sudo systemctl stop filebrowser

# Baixar nova versão
curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash

# Iniciar serviço
sudo systemctl start filebrowser
```

## 🔗 Recursos adicionais

- [Documentação oficial](https://filebrowser.org/)
- [GitHub](https://github.com/filebrowser/filebrowser)
- [Features](https://filebrowser.org/features)
- [Configuration](https://filebrowser.org/configuration)

## 🗑️ Desinstalação

### Método 1: Script (recomendado)

Baixe e execute o script:

```bash
# Baixar script
curl -fsSL https://raw.githubusercontent.com/gianfratti/Helper-Scripts/main/management/filebrowser/uninstall.sh -o uninstall.sh

# Executar
sudo bash uninstall.sh
```

### Método 2: Manual

```bash
# Parar e desabilitar serviço
sudo systemctl stop filebrowser
sudo systemctl disable filebrowser

# Remover arquivos
sudo rm /usr/local/bin/filebrowser
sudo rm /etc/systemd/system/filebrowser.service
sudo rm -rf /etc/filebrowser
sudo rm -rf /var/lib/filebrowser

# Recarregar systemd
sudo systemctl daemon-reload
```

## 👤 Autor

**Fabrizio Gianfratti**  
Brasil - São Paulo

---

⚠️ **Aviso:** Este script é fornecido como está. Sempre revise scripts antes de executá-los no seu sistema.