# cURL Installation

Script automatizado para instalação do cURL, uma ferramenta de linha de comando para transferir dados com URLs.

## 📝 Descrição

**cURL** (Client URL) é uma ferramenta de linha de comando e biblioteca para transferir dados usando vários protocolos de rede.

Suporta protocolos como:
- HTTP/HTTPS
- FTP/FTPS
- SCP/SFTP
- SMTP
- POP3
- IMAP
- E muitos outros

Usado para:
- Baixar arquivos da internet
- Testar APIs REST
- Fazer requisições HTTP/HTTPS
- Automatizar downloads
- Scripts de instalação remota
- Transferência de dados

## ⚙️ O que o script faz

1. Detecta automaticamente o sistema operacional
2. Atualiza o índice de pacotes
3. Instala o cURL via APT
4. Verifica se a instalação foi bem-sucedida
5. Exibe exemplos de uso

## 🚀 Como usar

> ⚠️ **IMPORTANTE**: Este script é o ponto de partida para usar outros scripts do repositório. Sem o cURL, você não consegue baixar os outros scripts remotamente.

### Instalação manual (PRIMEIRO PASSO)

Como você ainda não tem o cURL instalado, precisa instalar manualmente primeiro:

```bash
# Atualizar pacotes
sudo apt update

# Instalar cURL
sudo apt install curl -y

# Verificar instalação
curl --version
```

### Após instalar o cURL

Depois que o cURL estiver instalado, você poderá usar para baixar outros scripts:

```bash
# Instalar Git
curl -fsSL https://raw.githubusercontent.com/gianfratti/Helper-Scripts/main/tools/git/install.sh | sudo bash

# Instalar Docker
curl -fsSL https://raw.githubusercontent.com/gianfratti/Helper-Scripts/main/containers/docker/install.sh | sudo bash

# Instalar Webmin
curl -fsSL https://raw.githubusercontent.com/gianfratti/Helper-Scripts/main/management/webmin/install.sh | sudo bash
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

## 📖 Comandos cURL essenciais

### Download de arquivos

```bash
# Baixar arquivo e salvar com o mesmo nome
curl -O https://example.com/file.zip

# Baixar e salvar com nome diferente
curl -o meuarquivo.zip https://example.com/file.zip

# Baixar múltiplos arquivos
curl -O https://example.com/file1.txt -O https://example.com/file2.txt

# Continuar download interrompido
curl -C - -O https://example.com/largefile.iso

# Download com barra de progresso
curl -# -O https://example.com/file.zip
```

### Testar APIs

```bash
# GET request simples
curl https://api.example.com/users

# GET com headers
curl -H "Authorization: Bearer TOKEN" https://api.example.com/data

# POST com JSON
curl -X POST -H "Content-Type: application/json" \
  -d '{"name":"John","email":"john@example.com"}' \
  https://api.example.com/users

# POST com form data
curl -X POST -d "name=John&email=john@example.com" \
  https://api.example.com/users

# PUT request
curl -X PUT -H "Content-Type: application/json" \
  -d '{"name":"Jane"}' \
  https://api.example.com/users/123

# DELETE request
curl -X DELETE https://api.example.com/users/123
```

### Opções úteis

```bash
# Seguir redirecionamentos
curl -L https://bit.ly/shorturl

# Mostrar apenas headers de resposta
curl -I https://example.com

# Modo verboso (debug)
curl -v https://example.com

# Modo silencioso
curl -s https://example.com

# Salvar cookies
curl -c cookies.txt https://example.com

# Usar cookies salvos
curl -b cookies.txt https://example.com

# Definir User-Agent
curl -A "Mozilla/5.0" https://example.com

# Timeout de conexão
curl --connect-timeout 10 https://example.com

# Limitar velocidade de download
curl --limit-rate 100K -O https://example.com/file.zip
```

### Upload de arquivos

```bash
# Upload via POST
curl -F "file=@/path/to/file.txt" https://example.com/upload

# Upload com nome customizado
curl -F "file=@/path/to/file.txt;filename=newname.txt" \
  https://example.com/upload

# Upload via FTP
curl -T file.txt ftp://ftp.example.com/ --user username:password
```

### Autenticação

```bash
# Basic Authentication
curl -u username:password https://api.example.com

# Bearer Token
curl -H "Authorization: Bearer YOUR_TOKEN" https://api.example.com

# API Key
curl -H "X-API-Key: YOUR_API_KEY" https://api.example.com
```

### Trabalhar com JSON

```bash
# GET e formatar JSON (requer jq)
curl -s https://api.example.com/users | jq .

# Extrair campo específico
curl -s https://api.example.com/users | jq '.[] | .name'

# POST com arquivo JSON
curl -X POST -H "Content-Type: application/json" \
  -d @data.json https://api.example.com/users
```

## 🔧 Exemplos práticos

### Verificar IP público

```bash
curl ifconfig.me
curl ipinfo.io/ip
curl icanhazip.com
```

### Verificar clima

```bash
curl wttr.in
curl wttr.in/London
curl wttr.in/SaoPaulo?lang=pt
```

### Download de script e executar

```bash
# Baixar e executar script
curl -fsSL https://example.com/script.sh | bash

# Com sudo
curl -fsSL https://example.com/script.sh | sudo bash
```

### Testar velocidade de download

```bash
curl -o /dev/null https://speed.hetzner.de/100MB.bin
```

### Enviar notificação (webhook)

```bash
# Slack
curl -X POST -H 'Content-type: application/json' \
  --data '{"text":"Hello, World!"}' \
  YOUR_SLACK_WEBHOOK_URL

# Discord
curl -X POST -H "Content-Type: application/json" \
  -d '{"content":"Hello from cURL!"}' \
  YOUR_DISCORD_WEBHOOK_URL
```

## ⚠️ Troubleshooting

### Erro: "curl: command not found"

Instale o cURL:

```bash
sudo apt update
sudo apt install curl -y
```

### Erro de certificado SSL

```bash
# Ignorar verificação SSL (use com cuidado)
curl -k https://example.com

# Ou especificar certificado
curl --cacert /path/to/cert.pem https://example.com
```

### Timeout

```bash
# Aumentar timeout
curl --connect-timeout 30 --max-time 60 https://example.com
```

### Debug de conexão

```bash
# Modo verboso completo
curl -v https://example.com

# Mostrar apenas info da conexão
curl -w "\nHTTP Code: %{http_code}\nTime: %{time_total}s\n" \
  https://example.com
```

## 🔄 Atualizar cURL

```bash
# Atualizar via APT
sudo apt update
sudo apt upgrade curl -y

# Verificar versão
curl --version
```

## 📚 Recursos adicionais

- [Documentação oficial do cURL](https://curl.se/docs/)
- [cURL Manual](https://curl.se/docs/manual.html)
- [Everything cURL](https://everything.curl.dev/)
- [cURL Cookbook](https://catonmat.net/cookbooks/curl)

## 🔗 Alternativas

- **wget** - Similar ao cURL, focado em downloads
- **httpie** - Cliente HTTP mais user-friendly
- **aria2** - Download manager com suporte a torrents

## 🛠️ Desinstalação

Se precisar remover o cURL:

```bash
sudo apt remove curl -y
```

> ⚠️ **Atenção**: Não recomendado! O cURL é usado por muitos scripts e ferramentas do sistema.

## 👤 Autor

**Fabrizio Gianfratti**  
Brasil - São Paulo

---

⚠️ **Aviso:** Este script é fornecido como está. Sempre revise scripts antes de executá-los no seu sistema.