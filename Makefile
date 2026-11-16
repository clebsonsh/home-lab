.PHONY: help up down restart logs ps status clean prune

help: ## Mostra esta ajuda
	@echo "Comandos disponíveis:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

up: ## Inicia todos os serviços em background (detached)
	docker compose up -d

down: ## Para e remove os containers
	docker compose down

restart: ## Reinicia todos os serviços
	docker compose restart

logs: ## Mostra os logs de todos os serviços (Ctrl+C para sair)
	docker compose logs -f

ps: ## Lista os containers ativos
	docker compose ps

status: ## Exibe o status detalhado dos serviços
	docker compose top

pull: ## Atualiza as imagens dos containers
	docker compose pull

up-tmm: ## Inicia os serviços + o TinyMediaManager (que usa profile manual)
	docker compose --profile manual up -d tinymediamanager

down-tmm: ## Para os serviços incluindo o TinyMediaManager
	docker compose --profile manual down tinymediamanager

clean: ## Para os containers e remove volumes (CUIDADO: APAGA OS DADOS DOS VOLUMES DOCKER)
	docker compose down -v

prune: ## Remove containers parados, redes não utilizadas e cache de build
	docker system prune -f
