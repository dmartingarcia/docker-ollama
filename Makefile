# Use docker compose v2 if available, fall back to v1 otherwise
DOCKER_COMPOSE := $(shell command -v docker-compose || echo "docker compose")

.PHONY: help up down logs restart clean status pull

# Default target when running just 'make'
.DEFAULT_GOAL := help

# Help command that lists all available commands
help:
	@echo "Available commands:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  make %-10s - %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# Start all services
up: ## Start all services
	@if [ ! -f .env ]; then cp .env.example .env; fi
	@export $(shell sed 's/=.*//' .env)
	$(DOCKER_COMPOSE) up -d

down: ## Stop all services
	$(DOCKER_COMPOSE) down

logs: ## View logs from all services
	$(DOCKER_COMPOSE) logs -f

restart: ## Restart all services
	$(DOCKER_COMPOSE) restart

clean: ## Clean up containers, volumes, and images
	$(DOCKER_COMPOSE) down -v --rmi all

status: ## Check status of services
	$(DOCKER_COMPOSE) ps

pull: ## Pull latest images
	$(DOCKER_COMPOSE) pull

list-models: ## List all models
list-models: up
	docker exec -it ollama ollama list

run: ## Prepare and start all services
run: up rebuild-model

rebuild-model: ## Rebuild the custom model
	docker exec -it ollama ollama rm custom || true
	docker exec -it ollama ollama create custom -f /app/Modelfile
