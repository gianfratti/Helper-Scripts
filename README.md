# Helper-Scripts

A collection of helper scripts for system administration, automation, and DevOps tasks. Inspired by [ProxmoxVE Helper-Scripts](https://github.com/community-scripts/ProxmoxVE).

## 📁 Repository Structure

```
├── containers/
│   └── docker/
│       ├── README.md      # Docker documentation
│       └── install.sh     # Docker installation script
└── README.md
```

## 🚀 Available Scripts

### Containers

| Tool | Description | Documentation |
|------|-------------|---------------|
| **Docker** | Docker Engine + Docker Compose installation | [View docs](containers/docker/README.md) |

## 🛠️ Quick Start

### Docker Installation

```bash
# Clone and install
git clone https://github.com/gianfratti/Helper-Scripts.git
cd Helper-Scripts/containers/docker
sudo bash install.sh
```

Or direct installation:

```bash
curl -fsSL https://raw.githubusercontent.com/gianfratti/Helper-Scripts/main/containers/docker/install.sh | sudo bash
```

## 📝 Requirements

- Ubuntu/Debian-based systems
- Root or sudo privileges
- Internet connection

## 📂 Future Categories

Planned script categories:
- `databases/` - Database installation scripts
- `web-servers/` - Web server configurations
- `monitoring/` - Monitoring tools setup
- `tools/` - Utility scripts

## ⚠️ Disclaimer

These scripts are provided as-is. Always review scripts before running them on your system. Use at your own risk.

## 📄 License

This project is open source. Feel free to use, modify, and distribute.

---

**Author:** [gianfratti](https://github.com/gianfratti)  
**Location:** Brasil - São Paulo