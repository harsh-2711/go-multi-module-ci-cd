MODULES := $(shell find . -name go.mod -exec dirname {} \;)

.PHONY: update-deps
update-deps:
	@for module in $(MODULES); do \
		echo "Fetching dependencies for $$module"; \
		cd $$module && go get -u && go get -u all && go mod tidy; \
		cd - > /dev/null; \
	done

.PHONY: build-all
build-all:
	@for module in $(MODULES); do \
		echo "Building $$module"; \
		cd $$module; \
		go build -v -o /dev/null || exit 1 ; \
		cd - > /dev/null; \
	done

.PHONY: replace-deps
replace-deps:
	@if [ -z "$(package)" ]; then \
		echo "Package path required. Use: make replace-all package=<package-path> version=<version>" ; \
		exit 1; \
	fi
	@if [ -z "$(version)" ]; then \
		echo "Version required. Use: make replace-all package=<package-path> version=<version>" ; \
		exit 1; \
	fi
	@cd $(package); \
	DEPS=$$(go list -f '{{ join .Deps "\n" }}' . | grep 'github.com/harsh-2711/go-multi-module-ci-cd'); \
	for dep in $${DEPS}; do \
		sed -i '' 's|'$$dep' v[0-9.]*|'$$dep' '$(version)'|g' go.mod; \
	done; \
	go mod tidy; \
	go mod download; \
	go build -v -o /dev/null . || exit 1;

.PHONY: set-precommit-hooks
set-precommit-hooks:
	chmod ug+x .githooks/pre-commit && command -v git >/dev/null && git config core.hooksPath .githooks || true
