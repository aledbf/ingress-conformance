#!/usr/bin/env bash

# Copyright 2016 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit
set -o pipefail
set -o nounset

KUBE_ROOT=$(dirname "${BASH_SOURCE[0]}")/../vendor/k8s.io/kubernetes/
export KUBE_ROOT

if ! which go-bindata &>/dev/null ; then
	echo "Cannot find go-bindata."
	exit 5
fi

# These are files for e2e tests.
BINDATA_OUTPUT="${KUBE_ROOT}/test/e2e/generated/bindata.go"

go-bindata -nometadata -o "${BINDATA_OUTPUT}" -pkg generated \
	-ignore .jpg -ignore .png -ignore .md -ignore 'BUILD(\.bazel)?' \
	"${KUBE_ROOT}/test/e2e/generated/..."

gofmt -s -w "${BINDATA_OUTPUT}"
