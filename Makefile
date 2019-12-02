.PHONY: help build build-image test

help:
	# Document targets.

build:
	@./hack/build.sh

build-image: build
	@make -c images/conformance

test:
	@./hack/run.sh
