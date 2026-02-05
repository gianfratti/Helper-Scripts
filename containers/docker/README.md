# Docker & Docker Compose Installation

Script automatizado para instalação do Docker Engine e Docker Compose em sistemas Ubuntu/Debian.

## 📝 Descrição

Este script instala:
- **Docker Engine** (versão mais recente)
- **Docker Compose Plugin** (integrado ao Docker CLI)
- **Docker Compose Standalone** (binário independente)
- **Docker Buildx** (construtor multi-plataforma)

## ⚙️ O que o script faz

1. Detecta automaticamente o sistema operacional
2. Atualiza o índice de pacotes
3. Instala dependências necessárias
4. Adiciona a chave GPG oficial do Docker
5. Configura o repositório do Docker
6. Instala Docker Engine e componentes
7. Inicia e habilita o serviço Docker
8. Adiciona o usuário atual ao grupo `docker`
9. Instala Docker Compose standalone
10. Verifica as instalações

## 🚀 Como usar

### Instalação básica

```bash
# Clone o repositório
git clone https://github.com/gianfratti/Helper-Scripts.git
cd Helper-Scripts/containers/docker

# Execute o script
sudo bash install.sh
```

### Instalação direta (sem clone)

```bash
curl -fsSL https://raw.githubusercontent.com/gianfratti/Helper-Scripts/main/containers/docker/install.sh | sudo bash
```

## ✅ Requisitos

- Ubuntu 20.04+ ou Debian 10+
- Privilégios de root/sudo
- Conexão com a internet
- Arquitetura: x86_64 ou aarch64 (ARM64)

## 📊 Sistemas testados

- Ubuntu 20.04 LTS
- Ubuntu 22.04 LTS
- Ubuntu 24.04 LTS
- Debian 11 (Bullseye)
- Debian 12 (Bookworm)

## 🛠️ Pós-instalação

### Testar a instalação

```bash
# Testar Docker
docker run hello-world

# Verificar versões
docker --version
docker compose version
docker-compose --version
```

### Adicionar usuário ao grupo docker (se necessário)

```bash
sudo usermod -aG docker $USER
```

**Importante:** Faça logout e login novamente para que as alterações de grupo tenham efeito.

### Usar Docker sem sudo

Após adicionar seu usuário ao grupo `docker` e fazer novo login:

```bash
docker ps
docker images
docker compose version
```

## 📖 Comandos úteis

### Docker

```bash
# Listar containers em execução
docker ps

# Listar todos os containers
docker ps -a

# Listar imagens
docker images

# Remover container
docker rm <container_id>

# Remover imagem
docker rmi <image_id>

# Ver logs de um container
docker logs <container_id>

# Acessar shell de um container
docker exec -it <container_id> bash
```

### Docker Compose

```bash
# Iniciar serviços
docker compose up -d

# Parar serviços
docker compose down

# Ver logs
docker compose logs -f

# Reiniciar serviços
docker compose restart

# Ver status
docker compose ps
```

## ⚠️ Troubleshooting

### Erro: "Cannot connect to the Docker daemon"

```bash
# Verificar status do serviço
sudo systemctl status docker

# Iniciar o serviço
sudo systemctl start docker

# Habilitar para iniciar com o sistema
sudo systemctl enable docker
```

### Erro: "permission denied while trying to connect"

```bash
# Verificar se usuário está no grupo docker
groups

# Se não estiver, adicionar
sudo usermod -aG docker $USER

# Fazer logout e login novamente
```

### Reinstalar/Atualizar Docker

```bash
# Remover versão antiga
sudo apt-get remove docker docker-engine docker.io containerd runc

# Executar o script novamente
sudo bash install.sh
```

## 📚 Recursos adicionais

- [Documentação oficial do Docker](https://docs.docker.com/)
- [Documentação do Docker Compose](https://docs.docker.com/compose/)
- [Docker Hub](https://hub.docker.com/)

## 👤 Autor

**Fabrizio Gianfratti**  
Brasil - São Paulo

---

⚠️ **Aviso:** Este script é fornecido como está. Sempre revise scripts antes de executá-los no seu sistema.