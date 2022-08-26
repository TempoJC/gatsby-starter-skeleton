## Include .env file
include .env

## Root directory
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

## Set 'bash' as default shell
SHELL := $(shell which bash)

## Set 'help' target as the default goal
.DEFAULT_GOAL := help

.PHONY: help
help: ## Show this help
	@egrep -h '^[a-zA-Z0-9_\/-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort -d | awk 'BEGIN {FS = ":.*?## "; printf "Usage: make \033[0;34mTARGET\033[0m \033[0;35m[ARGUMENTS]\033[0m\n\n"; printf "Targets:\n"}; {printf "  \033[33m%-25s\033[0m \033[0;32m%s\033[0m\n", $$1, $$2}'

## Target specific variables

.PHONY: build
build: TAG ?= latest
build: ## Build image
	@echo "📦 Building project Docker image..."
	@docker build --build-arg PORT=$(PORT) -t $(APP_NAME):$(TAG) -f ./docker/Dockerfile .

.PHONY: start
start: ## Start application
	@echo "▶️ Starting app (Docker)..."
	@docker-compose -f ./docker/docker-compose.yml --env-file .env up --build

.PHONY: stop
stop: ## Start application
	@echo "🛑 Stopping app..."
	@docker-compose -f ./docker/docker-compose.yml --env-file .env down

.PHONY: clean
clean: ## Clean application
	@echo "🧼 Cleaning all resources..."
	@docker-compose -f ./docker/docker-compose.yml --env-file .env down --rmi local --volumes --remove-orphans
