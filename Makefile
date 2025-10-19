.PHONY: help install sync update clean test test-cov lint format type-check pre-commit build run

.DEFAULT_GOAL := help

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Install dependencies and setup pre-commit hooks
	uv sync --all-groups
	uv run pre-commit install
	uv run pre-commit install --hook-type commit-msg

sync: ## Sync dependencies
	uv sync --all-groups

update: ## Update dependencies
	uv lock --upgrade
	uv sync --all-groups

clean: ## Clean build artifacts and caches
	rm -rf build/
	rm -rf dist/
	rm -rf *.egg-info
	rm -rf .pytest_cache/
	rm -rf .ruff_cache/
	rm -rf htmlcov/
	rm -rf .coverage
	rm -rf coverage.xml
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	find . -type f -name "*.pyo" -delete

lint: ## Run linter (ruff)
	uv run --group lint ruff check .

lint-fix: ## Run linter with auto-fix
	uv run --group lint ruff check --fix .

format: ## Format code with ruff
	uv run --group lint ruff format .

format-check: ## Check code formatting
	uv run --group lint ruff format --check .

type-check: ## Run type checker (pyright)
	uv run --group type-check pyright

pre-commit: ## Run all pre-commit hooks
	uv run --group lint pre-commit run --all-files

ci: lint format-check type-check test ## Run all CI checks

build: ## Build all packages
	uv build

run: ## Run main application
	uv run python main.py

dev: ## Run application in development mode
	uv run python main.py

shell: ## Open Python shell with project dependencies
	uv run python

lock: ## Generate uv.lock file
	uv lock

tree: ## Show project dependency tree
	uv tree
