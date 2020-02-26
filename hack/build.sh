#!/usr/bin/env bash

if [ -n "$DEBUG" ]; then
  set -x
fi

set -o errexit
set -o nounset
set -o pipefail

KUBE_ROOT=$(dirname "${BASH_SOURCE[0]}")/..

export GO111MODULE=off

ginkgo build ${KUBE_ROOT}/test/e2e/
