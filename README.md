# Helper-Scripts

Coleção de scripts auxiliares para administração de sistemas, automação e tarefas DevOps. Inspirado em [ProxmoxVE Helper-Scripts](https://github.com/community-scripts/ProxmoxVE).

## 📁 Estrutura do Repositório

```
├── containers/       # Scripts para plataformas de containers
├── management/       # Ferramentas de gerenciamento de sistemas
├── tools/            # Ferramentas de desenvolvimento
└── README.md
```

## 🚀 Scripts Disponíveis

### Containers

| Ferramenta | Descrição | Documentação |
|------------|-----------|-------------|
| **Docker** | Instalação do Docker Engine e Docker Compose | [📖 Ver docs](containers/docker/) |

### Management (Gerenciamento)

| Ferramenta | Descrição | Documentação |
|------------|-----------|-------------|
| **File Browser** | Gerenciador de arquivos web-based | [📖 Ver docs](management/filebrowser/) |
| **Webmin** | Interface web para administração de sistemas | [📖 Ver docs](management/webmin/) |

### Tools (Ferramentas)

| Ferramenta | Descrição | Documentação |
|------------|-----------|-------------|
| **cURL** | Ferramenta de linha de comando para transferência de dados | [📖 Ver docs](tools/curl/) |
| **Git** | Sistema de controle de versão distribuído | [📖 Ver docs](tools/git/) |

## 🎯 Como Usar

### 🔴 Primeiro Passo: Instalar cURL

Antes de usar os outros scripts, você precisa ter o **cURL** instalado:

```bash
sudo apt update
sudo apt install curl -y
```

### 🟢 Depois, use o cURL para instalar outros scripts:

```bash
# Instalar Git
curl -fsSL https://raw.githubusercontent.com/gianfratti/Helper-Scripts/main/tools/git/install.sh | sudo bash

# Instalar Docker
curl -fsSL https://raw.githubusercontent.com/gianfratti/Helper-Scripts/main/containers/docker/install.sh | sudo bash

# Instalar Webmin
curl -fsSL https://raw.githubusercontent.com/gianfratti/Helper-Scripts/main/management/webmin/install.sh | sudo bash

# Instalar File Browser
curl -fsSL https://raw.githubusercontent.com/gianfratti/Helper-Scripts/main/management/filebrowser/install.sh | sudo bash
```

Cada ferramenta possui sua própria documentação detalhada com exemplos de uso, requisitos e troubleshooting.

## 📋 Requisitos Gerais

- Sistemas baseados em Ubuntu/Debian
- Privilégios de root ou sudo
- Conexão com a internet
- **cURL** instalado (primeiro requisito)

## 🔮 Categorias Futuras

Categorias planejadas:
- `databases/` - Scripts de instalação de bancos de dados
- `web-servers/` - Configurações de servidores web
- `monitoring/` - Ferramentas de monitoramento

## ⚠️ Aviso

Estes scripts são fornecidos como estão. Sempre revise os scripts antes de executá-los no seu sistema. Use por sua conta e risco.

## 📄 Licença

Este projeto é open source. Sinta-se livre para usar, modificar e distribuir.

---

**Autor:** [gianfratti](https://github.com/gianfratti)  
**Localização:** Brasil - São Paulo