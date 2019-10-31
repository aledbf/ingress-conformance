#!/usr/bin/env bash

if [ -n "$DEBUG" ]; then
  set -x
fi

set -o errexit
set -o nounset
set -o pipefail

export GO111MODULE=off

ginkgo build ./test/e2e/
