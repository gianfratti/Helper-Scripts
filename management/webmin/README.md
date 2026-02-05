# Webmin Installation

Script automatizado para instalação do Webmin, uma ferramenta de administração de sistemas baseada em interface web.

## 📝 Descrição

**Webmin** é uma interface web moderna para administração de sistemas Unix/Linux. Permite gerenciar seu servidor através de qualquer navegador moderno, facilitando tarefas como:

- Gerenciamento de usuários e grupos
- Configuração de serviços (Apache, MySQL, PostgreSQL, etc.)
- Gerenciamento de arquivos com editor integrado
- Monitoramento do sistema
- Backup e restauração
- Gerenciamento de pacotes
- Configuração de firewall
- Agendamento de tarefas (cron)
- E muito mais!

## ⚙️ O que o script faz

1. Detecta automaticamente o sistema operacional
2. Atualiza o índice de pacotes e sistema
3. Instala dependências necessárias
4. Baixa o script oficial de configuração do repositório Webmin
5. Configura o repositório oficial do Webmin
6. Instala o Webmin com pacotes recomendados
7. Habilita e inicia o serviço Webmin
8. Verifica se o serviço está rodando
9. Exibe informações de acesso

## 🚀 Como usar

### Instalação básica

```bash
# Clone o repositório
git clone https://github.com/gianfratti/Helper-Scripts.git
cd Helper-Scripts/management/webmin

# Execute o script
sudo bash install.sh
```

### Instalação direta (sem clone)

```bash
curl -fsSL https://raw.githubusercontent.com/gianfratti/Helper-Scripts/main/management/webmin/install.sh | sudo bash
```

## ✅ Requisitos

- Ubuntu 20.04+ ou Debian 10+
- Privilégios de root/sudo
- Conexão com a internet
- Porta 10000 disponível (padrão do Webmin)

## 📊 Sistemas testados

- Ubuntu 20.04 LTS
- Ubuntu 22.04 LTS
- Ubuntu 24.04 LTS
- Debian 11 (Bullseye)
- Debian 12 (Bookworm)

## 🌐 Acesso ao Webmin

### URL de acesso

Após a instalação, acesse:

```
https://<seu-ip>:10000
```

Ou se estiver no próprio servidor:

```
https://localhost:10000
```

### Credenciais de login

- **Usuário:** root (ou qualquer usuário do sistema)
- **Senha:** A senha do usuário do sistema

### Aviso de segurança

O Webmin usa um certificado SSL auto-assinado por padrão. Seu navegador mostrará um aviso de segurança - isso é normal. Você pode:

1. **Aceitar o risco** e continuar (para uso local/teste)
2. **Configurar um certificado válido** (Let's Encrypt) através da própria interface do Webmin

## 🔧 Configuração Pós-Instalação

### Verificar status do serviço

```bash
# Ver status
sudo systemctl status webmin

# Parar serviço
sudo systemctl stop webmin

# Iniciar serviço
sudo systemctl start webmin

# Reiniciar serviço
sudo systemctl restart webmin
```

### Configurar firewall (UFW)

Se você usa UFW, libere a porta:

```bash
sudo ufw allow 10000/tcp
sudo ufw reload
```

### Mudar a porta padrão

Edite o arquivo de configuração:

```bash
sudo nano /etc/webmin/miniserv.conf
```

Procure por `port=10000` e altere para a porta desejada.

Reinicie o Webmin:

```bash
sudo systemctl restart webmin
```

### Configurar certificado SSL (Let's Encrypt)

1. Acesse o Webmin via navegador
2. Vá em **Webmin** → **Webmin Configuration** → **SSL Encryption**
3. Clique em **Let's Encrypt**
4. Preencha seu domínio e email
5. Clique em **Request Certificate**

## 📖 Funcionalidades principais

### Gerenciamento de Sistema
- Informações do sistema e hardware
- Processos em execução
- Logs do sistema
- Agendador de tarefas (Cron)
- Inicialização e shutdown

### Servidores
- Apache Web Server
- MySQL/MariaDB
- PostgreSQL
- ProFTPD
- BIND DNS Server
- Postfix/Sendmail

### Rede
- Configuração de rede
- Firewall (iptables)
- Serviços de rede
- Hospedagem virtual

### Usuários e Grupos
- Criar/editar usuários
- Gerenciar grupos
- Quotas de disco
- Permissões de arquivos

### Arquivos
- Navegador de arquivos
- Editor de texto integrado
- Upload/download de arquivos
- Permissões e propriedade

### Backup
- Backup de sistemas de arquivos
- Backup de bancos de dados
- Restauração
- Agendamento de backups

## ⚠️ Troubleshooting

### Erro: "Porta 10000 já em uso"

Verifique se outro serviço está usando a porta:

```bash
sudo netstat -tulpn | grep 10000
```

Altere a porta do Webmin ou pare o outro serviço.

### Erro: "Não consigo acessar via navegador"

Verifique:

1. Se o serviço está rodando: `sudo systemctl status webmin`
2. Se o firewall está bloqueando: `sudo ufw status`
3. Se você está usando **https://** (não http://)

### Erro: "Forgot root password"

Você pode resetar usando:

```bash
sudo /usr/share/webmin/changepass.pl /etc/webmin root newpassword
sudo systemctl restart webmin
```

### Atualizar Webmin

O Webmin se atualiza automaticamente via apt:

```bash
sudo apt update
sudo apt upgrade webmin
```

Ou atualize pela própria interface: **Webmin** → **Webmin Configuration** → **Upgrade Webmin**

## 🔒 Segurança

### Recomendações de segurança:

1. **Use HTTPS**: Sempre acesse via https://
2. **Configure Let's Encrypt**: Substitua o certificado auto-assinado
3. **Firewall**: Restrinja acesso à porta 10000 apenas para IPs confiáveis
4. **Senhas fortes**: Use senhas complexas para usuários
5. **Two-Factor Auth**: Configure autenticação de dois fatores
6. **Mantenha atualizado**: Atualize regularmente o Webmin

### Restringir acesso por IP (UFW)

```bash
# Permitir apenas de um IP específico
sudo ufw allow from 192.168.1.100 to any port 10000

# Permitir de uma rede
sudo ufw allow from 192.168.1.0/24 to any port 10000
```

## 🔗 Recursos adicionais

- [Documentação oficial do Webmin](https://webmin.com/docs/)
- [Webmin Wiki](https://doxfer.webmin.com/Webmin/Main_Page)
- [Fórum oficial](https://forum.virtualmin.com/)
- [GitHub do Webmin](https://github.com/webmin/webmin)

## 🗑️ Desinstalação

### Usando o script de desinstalação (recomendado)

```bash
# Clone o repositório
git clone https://github.com/gianfratti/Helper-Scripts.git
cd Helper-Scripts/management/webmin

# Execute o script de desinstalação
sudo bash uninstall.sh
```

### Desinstalação direta (sem clone)

```bash
curl -fsSL https://raw.githubusercontent.com/gianfratti/Helper-Scripts/main/management/webmin/uninstall.sh | sudo bash
```

### Desinstalação manual

Se preferir desinstalar manualmente:

```bash
# Parar o serviço
sudo systemctl stop webmin

# Desinstalar
sudo apt remove --purge webmin -y

# Remover repositório
sudo rm /etc/apt/sources.list.d/webmin.list

# Remover chave GPG
sudo rm /usr/share/keyrings/webmin.gpg

# Atualizar índice de pacotes
sudo apt update
```

## 👤 Autor

**Fabrizio Gianfratti**  
Brasil - São Paulo

---

⚠️ **Aviso:** Este script é fornecido como está. Sempre revise scripts antes de executá-los no seu sistema.