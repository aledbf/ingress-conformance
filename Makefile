.PHONY: help build test

help:
	# Document targets.

build:
	@./hack/build.sh

test:
	@./hack/run.sh
