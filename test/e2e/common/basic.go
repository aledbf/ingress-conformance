/*
Copyright 2019 The Kubernetes Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package common

import (
	"k8s.io/kubernetes/test/e2e/framework"

	"github.com/onsi/ginkgo"
)

var _ = ginkgo.Describe("[sig-network] Ingress", func() {
	framework.NewDefaultFramework("defaultbackend")

	/*
	   Testname: Without host rule or path should send traffic to the default backend
	   Description: Without a path, Ingress assumes / as default path
	   Release : v1.19
	*/
	framework.ConformanceIt("should send traffic to the default backend service using path /", func() {
		framework.SkipIfNodeOSDistroIs("windows")
	})
})
