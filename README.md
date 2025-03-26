# Docker Ollama with Web UI

This project provides a Docker setup for running Ollama AI locally with an intuitive web interface. Using Docker and Docker Compose, you can easily set up and manage your own instance of Ollama AI on your local machine.

## 🎯 Advantages of Running Ollama AI Locally

- **Privacy**: Keep your data secure by processing it locally
- **Performance**: Reduce latency by avoiding network calls to external services
- **Customization**: Tailor the AI to your specific needs without relying on third-party services
- **Cost**: Save on costs associated with cloud-based AI services

## 🚀 Features

- [Ollama AI](https://github.com/ollama/ollama) model server with GPU support
- [Open WebUI](https://github.com/open-webui/open-webui) for easy interaction with models
- Persistent storage for models and configurations
- Health checking and automatic restart
- Traefik integration for reverse proxy support
- Makefile for easy management
- Easily customizable using the Modelfile

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
- `make rebuild-model` - Rebuild the custom AI model

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

## 🖥️ NVIDIA GPU Setup

To enable GPU support for your Docker containers, you need to install the NVIDIA Container Toolkit. Follow these steps:

### Install NVIDIA Container Toolkit

[Here's the latest version of the Nvidia documentation.](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/sample-workload.html)

I would recommend to follow the documentation, or the [docker hub documentation](https://hub.docker.com/r/ollama/ollama) as it should be more up-to-date, but just in case you're in a hurry...

1. Set up the package repository and the GPG key:
    ```bash
    curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey \
      | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
    curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list \
      | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' \
      | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
    sudo apt-get update
    ```

2. Install the NVIDIA Container Toolkit:
    ```bash
    sudo apt-get install -y nvidia-container-toolkit
    sudo nvidia-ctk runtime configure --runtime=docker
    sudo systemctl restart docker
    ```

### Run Containers with GPU Access

To check if GPUS are accesible run the following command:

```bash
docker run --gpus all nvidia/cuda:11.0-base nvidia-smi
```

In your `docker-compose.yml`, ensure you have the following configuration for services requiring GPU access:

```yaml
services:
  ollama:
    image: ollama/ollama:latest
    deploy:
      resources:
        reservations:
          devices:
            - capabilities: [gpu]
    runtime: nvidia
    environment:
      - NVIDIA_VISIBLE_DEVICES=all
      - NVIDIA_DRIVER_CAPABILITIES=compute,utility
```

This configuration ensures that the Ollama service has access to the GPU and the necessary CUDA environment.

## 🔒 Security Note

Remember to change the default credentials after your first login to the Web UI for security purposes.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.