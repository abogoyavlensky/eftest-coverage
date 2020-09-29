# Styling for output
YELLOW := "\e[1;33m"
NC := "\e[0m"
INFO := @sh -c '\
    printf $(YELLOW); \
    echo "=> $$1"; \
    printf $(NC)' VALUE


.SILENT:  # Ignore output of make `echo` command


.PHONY: help  # Show list of targets with descriptions
help:
	@$(INFO) "Commands:"
	@grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\)/\1 > \2/' | column -tx -s ">"


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
