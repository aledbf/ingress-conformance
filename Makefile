# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'
.DEFAULT_GOAL:=help

.PHONY: help build build-image test dep-ensure check-go-version update-conformance-list

.EXPORT_ALL_VARIABLES:

ifndef VERBOSE
.SILENT:
endif

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

build: check-go-version ## Build ginkgo e2e test binary
	@./hack/build.sh

build-image: build ## Build image to run conformance test suite
	@make -C images/conformance

test: ## Run conformance tests
	@mkdir -p "/tmp/results"
	@RESULTS_DIR="/tmp/results" \
	E2E_FOCUS="\\[Conformance\\]" \
	E2E_SKIP="" \
	E2E_PROVIDER="skeleton" \
	E2E_PARALLEL="false" \
	E2E_VERBOSITY="4" \
	E2E_BINARY="test/e2e/e2e.test" \
	./images/conformance/e2e.sh

update-conformance-list: ## Updates the document conformance.md with the currect e2e suite definition
	@rm conformance.md
	@go run test/conformance/walk.go \
		--conformance=true test/e2e > conformance.md

check-go-version:
	@hack/check-go-version.sh

dep-ensure: check-go-version ## Update and vendor go dependencies.
	go mod tidy -v
	find vendor -name '*_test.go' -delete
	go mod vendor
	./hack/generate-bindata.sh
