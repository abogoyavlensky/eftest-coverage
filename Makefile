# Styling for output
YELLOW := "\e[1;33m"
NC := "\e[0m"
INFO := @sh -c '\
    printf $(YELLOW); \
    echo "=> $$1"; \
    printf $(NC)' VALUE


DIRS?=src test

.SILENT:  # Ignore output of make `echo` command


.PHONY: help  # Show list of targets with descriptions
help:
	@$(INFO) "Commands:"
	@grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\)/\1 > \2/' | column -tx -s ">"


.PHONY: deps  # Install deps
deps:
	@$(INFO) "Install deps..."
	@clojure -P -M:dev:test


.PHONY: build  # Build a deployable jar
build:
	@$(INFO) "Building jar..."
	@clojure -M:build


.PHONY: install  # Build and install package locally
install:
	@$(MAKE) build
	@$(INFO) "Installing jar locally..."
	@clojure -M:install


.PHONY: deploy  # Build and deploy package to Clojars
deploy:
	@$(MAKE) build
	@$(INFO) "Deploying jar to Clojars..."
	@clojure -M:deploy

.PHONY: slim  # Slim build and deploy
slim-snapshot:
	@clojure -T:slim deploy :snapshot true

# TODO: remove cmd repition!

.PHONY: fmt-check  # Checking code formatting
fmt-check:
	@$(INFO) "Checking code formatting..."
	@cljstyle check --report $(DIRS)


.PHONY: fmt  # Fixing code formatting
fmt:
	@$(INFO) "Fixing code formatting..."
	@cljstyle fix --report $(DIRS)


.PHONY: fmt-check-ci  # Checking code formatting, should be used in CI
fmt-check-ci:
	@$(INFO) "Checking code formatting..."
	@FMT_ACTION=check FMT_PATHS=$(SOURCE_PATHS) docker-compose run fmt


.PHONY: lint  # Linting code
lint:
	@$(INFO) "Linting project..."
	@clj-kondo --config .clj-kondo/config-ci.edn --lint $(DIRS)


.PHONY: lint-init  # Linting code with libraries
lint-init:
	@$(INFO) "Linting project's classpath..."
	@clj-kondo --config .clj-kondo/config-ci.edn --lint $(shell clj -Spath)


.PHONY: lint-init-ci  # Linting code with libraries, should be used in CI
lint-init-ci:
	@$(INFO) "Linting project's classpath..."
	@LINT_PATHS=$(shell clj -Spath) docker-compose run lint || true


.PHONY: test  # Run tests with coverage
test:
	@$(INFO) "Running tests..."
	@clojure -M:dev:test
