# Git Installation

Script automatizado para instalação do Git, o sistema de controle de versão distribuído mais popular do mundo.

## 📝 Descrição

**Git** é um sistema de controle de versão distribuído gratuito e open source, projetado para lidar com projetos de qualquer tamanho com velocidade e eficiência.

Usado por milhões de desenvolvedores e empresas ao redor do mundo para:
- Controlar versões de código-fonte
- Colaborar em projetos de software
- Gerenciar histórico de mudanças
- Trabalhar com branches e merges
- Integrar com GitHub, GitLab, Bitbucket, etc.

## ⚙️ O que o script faz

1. Detecta automaticamente o sistema operacional
2. Atualiza o índice de pacotes
3. Instala o Git via APT
4. Verifica se a instalação foi bem-sucedida
5. Exibe próximos passos para configuração

## 🚀 Como usar

### Instalação básica

```bash
# Clone o repositório
git clone https://github.com/gianfratti/Helper-Scripts.git
cd Helper-Scripts/tools/git

# Execute o script
sudo bash install.sh
```

### Instalação direta (sem clone)

```bash
curl -fsSL https://raw.githubusercontent.com/gianfratti/Helper-Scripts/main/tools/git/install.sh | sudo bash
```

### Instalação manual (alternativa)

```bash
sudo apt update
sudo apt install git -y
```

## ✅ Requisitos

- Ubuntu 20.04+ ou Debian 10+
- Privilégios de root/sudo
- Conexão com a internet

## 📊 Sistemas testados

- Ubuntu 20.04 LTS
- Ubuntu 22.04 LTS
- Ubuntu 24.04 LTS
- Debian 11 (Bullseye)
- Debian 12 (Bookworm)

## 🛠️ Configuração Pós-Instalação

### 1. Configurar identidade (obrigatório)

Antes de usar o Git, configure seu nome e email:

```bash
# Configurar nome
git config --global user.name "Seu Nome"

# Configurar email
git config --global user.email "seu.email@example.com"
```

### 2. Verificar configuração

```bash
# Ver todas as configurações
git config --list

# Ver apenas nome e email
git config user.name
git config user.email
```

### 3. Configurar editor padrão (opcional)

```bash
# Usar nano
git config --global core.editor nano

# Usar vim
git config --global core.editor vim

# Usar VS Code
git config --global core.editor "code --wait"
```

### 4. Configurar branch padrão

```bash
# Usar 'main' como branch padrão (recomendado)
git config --global init.defaultBranch main
```

## 🔑 Configurar SSH para GitHub/GitLab

### Gerar chave SSH

```bash
# Gerar chave SSH (ED25519 - recomendado)
ssh-keygen -t ed25519 -C "seu.email@example.com"

# Ou RSA (se ED25519 não for suportado)
ssh-keygen -t rsa -b 4096 -C "seu.email@example.com"
```

Pressione Enter para aceitar o local padrão (`~/.ssh/id_ed25519`).

### Adicionar chave ao ssh-agent

```bash
# Iniciar ssh-agent
eval "$(ssh-agent -s)"

# Adicionar chave privada
ssh-add ~/.ssh/id_ed25519
```

### Copiar chave pública

```bash
# Exibir chave pública
cat ~/.ssh/id_ed25519.pub
```

Copie a saída e adicione em:
- **GitHub**: Settings → SSH and GPG keys → New SSH key
- **GitLab**: Preferences → SSH Keys → Add new key
- **Bitbucket**: Personal settings → SSH keys → Add key

### Testar conexão

```bash
# GitHub
ssh -T git@github.com

# GitLab
ssh -T git@gitlab.com

# Bitbucket
ssh -T git@bitbucket.org
```

## 📖 Comandos Git essenciais

### Iniciar repositório

```bash
# Criar novo repositório
git init

# Clonar repositório existente
git clone https://github.com/usuario/repositorio.git

# Clonar via SSH
git clone git@github.com:usuario/repositorio.git
```

### Comandos básicos

```bash
# Ver status
git status

# Adicionar arquivos
git add arquivo.txt
git add .  # Adicionar todos

# Commit
git commit -m "Mensagem do commit"

# Ver histórico
git log
git log --oneline  # Resumido

# Push (enviar para remoto)
git push origin main

# Pull (baixar do remoto)
git pull origin main
```

### Branches

```bash
# Listar branches
git branch

# Criar branch
git branch nova-branch

# Mudar de branch
git checkout nova-branch

# Criar e mudar de branch
git checkout -b nova-branch

# Deletar branch
git branch -d nome-branch

# Merge de branch
git checkout main
git merge nova-branch
```

### Desfazer mudanças

```bash
# Descartar mudanças locais
git checkout -- arquivo.txt

# Desfazer último commit (mantém mudanças)
git reset --soft HEAD~1

# Desfazer último commit (descarta mudanças)
git reset --hard HEAD~1

# Reverter commit (cria novo commit)
git revert <commit-hash>
```

## 🔧 Configurações úteis

### Aliases (atalhos)

```bash
# Criar aliases
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.last 'log -1 HEAD'

# Usar aliases
git st     # = git status
git co main  # = git checkout main
```

### Cores no terminal

```bash
# Ativar cores
git config --global color.ui auto
```

### Credenciais (cache)

```bash
# Cache de credenciais por 1 hora
git config --global credential.helper 'cache --timeout=3600'

# Cache permanente (Linux)
git config --global credential.helper store
```

## 📚 Arquivos de configuração

### Localização dos arquivos

- **Global**: `~/.gitconfig` (configurações do usuário)
- **Local**: `.git/config` (configurações do repositório)
- **Sistema**: `/etc/gitconfig` (configurações do sistema)

### .gitignore

Criar arquivo `.gitignore` na raiz do projeto para ignorar arquivos:

```bash
# Exemplo de .gitignore
*.log
*.tmp
node_modules/
.env
.DS_Store
__pycache__/
*.pyc
```

## ⚠️ Troubleshooting

### Erro: "Permission denied (publickey)"

```bash
# Verificar se chave SSH está adicionada
ssh-add -l

# Se não estiver, adicionar
ssh-add ~/.ssh/id_ed25519
```

### Erro: "fatal: not a git repository"

Você está fora de um repositório Git. Navegue até o diretório correto ou inicialize um:

```bash
git init
```

### Conflitos de merge

```bash
# Ver arquivos com conflito
git status

# Editar arquivos manualmente
# Procure por: <<<<<<< HEAD

# Após resolver
git add arquivo-resolvido.txt
git commit -m "Resolve merge conflict"
```

### Reverter para commit anterior

```bash
# Ver histórico
git log --oneline

# Reverter para commit específico
git checkout <commit-hash>

# Voltar para branch principal
git checkout main
```

## 🔄 Atualizar Git

```bash
# Atualizar via APT
sudo apt update
sudo apt upgrade git -y

# Verificar versão
git --version
```

## 📚 Recursos adicionais

- [Documentação oficial do Git](https://git-scm.com/doc)
- [Git Book (gratuito)](https://git-scm.com/book/pt-br/v2)
- [GitHub Guides](https://guides.github.com/)
- [Git Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)
- [Visualizing Git](https://git-school.github.io/visualizing-git/)

## 🎓 Tutoriais interativos

- [Learn Git Branching](https://learngitbranching.js.org/?locale=pt_BR)
- [GitHub Learning Lab](https://lab.github.com/)
- [Git Immersion](http://gitimmersion.com/)

## 🛠️ Desinstalação

Se precisar remover o Git:

```bash
# Desinstalar
sudo apt remove git -y

# Remover configurações (opcional)
rm -rf ~/.gitconfig
rm -rf ~/.ssh/id_*
```

## 👤 Autor

**Fabrizio Gianfratti**  
Brasil - São Paulo

---

⚠️ **Aviso:** Este script é fornecido como está. Sempre revise scripts antes de executá-los no seu sistema.