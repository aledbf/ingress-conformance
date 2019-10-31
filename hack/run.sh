#!/usr/bin/env bash

if [ -n "$DEBUG" ]; then
	set -x
fi

set -o errexit
set -o nounset
set -o pipefail

ginkgo_args=(
  "-randomizeSuites"
  "-randomizeAllSpecs"
  "-flakeAttempts=2"
  "-p"
  "-trace"
  "-r"
  "--noColor=true"
)

ginkgo "${ginkgo_args[@]}" \
  -focus=\[Conformance\] \
  -skip="\[Serial\]" \
  ./test/e2e/e2e.test

ginkgo "${ginkgo_args[@]}" \
  -focus=\[Serial\].*\[Conformance\] \
  ./test/e2e/e2e.test
