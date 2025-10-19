.PHONY: all help test tests test-unit test-integration test-all test-watch test-cov test-profile benchmark lint lint-fix format format-check format-diff type-check clean check ci

# Default target executed when no arguments are given to make.
all: help

# Define a variable for the test file path.
TEST_FILE ?= tests/unit_tests/

# Root directory (2 levels up from packages/core)
ROOT_DIR := ../..

######################
# TESTING
######################

test tests: ## Run unit tests
	cd $(ROOT_DIR) && uv run --group test pytest packages/core/$(TEST_FILE) -v

test-unit: ## Run unit tests only
	cd $(ROOT_DIR) && uv run --group test pytest packages/core/tests/unit_tests -v

test-integration: ## Run integration tests only
	cd $(ROOT_DIR) && uv run --group test pytest packages/core/tests/integration_tests -v

test-all: ## Run all tests (unit + integration)
	cd $(ROOT_DIR) && uv run --group test pytest packages/core/tests -v

test-watch: ## Run tests in watch mode
	cd $(ROOT_DIR) && uv run --group test pytest-watcher packages/core/$(TEST_FILE)

test-cov: ## Run tests with coverage
	cd $(ROOT_DIR) && uv run --group test pytest packages/core/tests \
		--cov=packages/core/src/core \
		--cov-report=term-missing \
		--cov-report=html \
		--cov-report=xml \
		-v

test-profile: ## Run tests with profiling
	cd $(ROOT_DIR) && uv run --group test pytest packages/core/tests/unit_tests -vv --profile-svg

benchmark: ## Run benchmarks
	cd $(ROOT_DIR) && uv run --group test pytest packages/core/tests/benchmarks --benchmark-only -v

######################
# LINTING AND FORMATTING
######################

PACKAGE_DIR=packages/core

lint: ## Run linter (ruff check)
	cd $(ROOT_DIR) && uv run --group lint ruff check $(PACKAGE_DIR)

lint-fix: ## Run linter with auto-fix
	cd $(ROOT_DIR) && uv run --group lint ruff check --fix $(PACKAGE_DIR)

format: ## Format code with ruff
	cd $(ROOT_DIR) && uv run --group lint ruff format $(PACKAGE_DIR)

format-check: ## Check code formatting without making changes
	cd $(ROOT_DIR) && uv run --group lint ruff format --check $(PACKAGE_DIR)

format-diff: ## Show formatting differences
	cd $(ROOT_DIR) && uv run --group lint ruff format --diff $(PACKAGE_DIR)

type-check: ## Run type checker (pyright)
	cd $(ROOT_DIR) && uv run --group type-check pyright $(PACKAGE_DIR)

######################
# CLEANING
######################

clean: ## Clean cache files and build artifacts
	rm -rf __pycache__
	rm -rf src/**/__pycache__
	rm -rf tests/**/__pycache__
	rm -rf .pytest_cache
	rm -rf .ruff_cache
	rm -rf htmlcov
	rm -rf .coverage
	rm -rf coverage.xml
	rm -rf prof
	find . -type f -name "*.pyc" -delete
	find . -type f -name "*.pyo" -delete
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true

######################
# COMBINED CHECKS
######################

check: lint format-check type-check ## Run all checks (lint, format, type-check)

ci: check ## Run all CI checks (alias for check)

######################
# HELP
######################

help: ## Show this help message
	@echo '===================='
	@echo 'Core Package Tasks'
	@echo '===================='
	@echo ''
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@echo ''
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo ''
	@echo 'Examples:'
	@echo '  make test                    - Run unit tests'
	@echo '  make test TEST_FILE=tests/   - Run all tests'
	@echo '  make test-cov                - Run tests with coverage'
	@echo '  make check                   - Run all checks'
