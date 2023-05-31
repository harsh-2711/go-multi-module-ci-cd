MODULES := $(shell find . -name go.mod -exec dirname {} \;)
PACKAGES := $(shell find ./packages -name go.mod -exec dirname {} \;)
SERVICES := $(shell find ./services -name go.mod -exec dirname {} \;)

.PHONY: setup-workspace
setup-workspace:
	go work init; \
	for module in $(MODULES); do \
		echo "Setting up workspace for $$module"; \
		go work use $$module; \
	done

define update_target
	for module in $(1); do \
		echo "Fetching dependencies for $$module"; \
		cd $$module && go get -u && go get -u all && go mod tidy; \
		cd - > /dev/null; \
	done
endef

.PHONY: update-all-deps
update-all-deps:
	@$(call update_target,$(MODULES))

.PHONY: update-package-deps
update-package-deps:
	@$(call update_target,$(PACKAGES))

.PHONY: update-service-deps
update-service-deps:
	@$(call update_target,$(SERVICES))

define build_target
	for module in $(1); do \
		echo "Building $$module"; \
		cd $$module; \
		go build -v -o /dev/null || exit 1 ; \
		cd - > /dev/null; \
	done
endef

.PHONY: build-all
build-all:
	@$(call build_target,$(MODULES))

.PHONY: build-all-packages
build-all-packages:
	@$(call build_target,$(PACKAGES))

.PHONY: build-all-services
build-all-services:
	@$(call build_target,$(SERVICES))

.PHONY: replace-deps
replace-deps:
	@if [ -z "$(module)" ]; then \
		echo "Module path required. Use: make replace-all module=<module-path> version=<version>" ; \
		exit 1; \
	fi
	@if [ -z "$(version)" ]; then \
		echo "Version required. Use: make replace-all module=<module-path> version=<version>" ; \
		exit 1; \
	fi
	@cd $(module); \
	DEPS=$$(go list -f '{{ join .Deps "\n" }}' . | grep 'github.com/harsh-2711/go-multi-module-ci-cd/packages'); \
	for dep in $${DEPS}; do \
		sed -i 's|'$$dep' v[0-9.]*|'$$dep' '$(version)'|g' go.mod; \
	done; \
	go mod tidy; \
	go mod download; \
	go build -v -o /dev/null . || exit 1;

.PHONY: set-precommit-hooks
set-precommit-hooks:
	chmod ug+x .githooks/pre-commit && command -v git >/dev/null && git config core.hooksPath .githooks || true
