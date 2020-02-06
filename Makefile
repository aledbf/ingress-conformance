# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'
.DEFAULT_GOAL:=help

.PHONY: help build build-image test dep-ensure check-go-version

.EXPORT_ALL_VARIABLES:

ifndef VERBOSE
.SILENT:
endif

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

build: check-go-version ## Build ginkgo e2e test binary
	@./hack/build.sh

build-image: build ## Build image to run conformance test suite
	@make -c images/conformance

test: ## Run conformance tests
	@./hack/run.sh

check-go-version:
	@hack/check-go-version.sh

dep-ensure: check-go-version ## Update and vendor go dependencies.
	GO111MODULE=on go mod tidy -v
	find vendor -name '*_test.go' -delete
	GO111MODULE=on go mod vendor
