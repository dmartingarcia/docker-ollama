# Docker Ollama with Web UI

This project provides a Docker setup for running Ollama AI locally with an intuitive web interface. Using Docker and Docker Compose, you can easily set up and manage your own instance of Ollama AI on your local machine.

## 🎯 Advantages of Running Ollama AI Locally

- **Privacy**: Keep your data secure by processing it locally
- **Performance**: Reduce latency by avoiding network calls to external services
- **Customization**: Tailor the AI to your specific needs without relying on third-party services
- **Cost**: Save on costs associated with cloud-based AI services

## 🚀 Features

- Ollama AI model server with GPU support
- Open WebUI for easy interaction with models
- Persistent storage for models and configurations
- Health checking and automatic restart
- Traefik integration for reverse proxy support
- Makefile for easy management

## 📋 Prerequisites

- Docker and Docker Compose
- NVIDIA GPU with appropriate drivers (optional)
- Make (for using the Makefile commands)

## 🛠️ Getting Started

### Clone the Repository

```bash
git clone https://github.com/dmartingarcia/docker-ollama.git
cd docker-ollama
```

### Quick Start

1. Start the services:
```bash
make up
```

It will pull the R1 model by default, but you can change it on the Makefile to any other model

2. Access the Web UI at `http://localhost:8080`

## 📦 Available Make Commands

Show available commands
- `make list-models` - List all models
- `make run` - Prepare and start all services
- `make help` - Show available commands
- `make up` - Start all services
- `make down` - Stop all services
- `make logs` - View logs
- `make restart` - Restart services
- `make clean` - Remove all containers and data
- `make status` - Check service status
- `make pull` - Update images

## 🗂 Directory Structure

```
docker-ollama/
├── docker-compose.yml
├── Makefile
└── config/
    ├── ollama/      # Ollama models and config
    └── open-webui/  # WebUI data and settings
```

## ⚙️ Configuration

The setup includes:
- GPU passthrough for Ollama
- Persistent storage for models and configurations
- Automatic container restart
- Health checks for reliability
- Traefik labels for reverse proxy setup

## 🔒 Security Note

Remember to change the default credentials after your first login to the Web UI for security purposes.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.