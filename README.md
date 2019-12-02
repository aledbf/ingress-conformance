# ingress-conformance
Conformance test suite for Kubernetes Ingress (POC)

**Run:**
- `make build` build e2e.test binary
- `make test`  runs e2e suite against an existing Kubernetes cluster (uses current context from KUBECONFIG)

**TODO:**

- [X] Build docker image
- [ ] Use [Sonoboy](https://github.com/vmware-tanzu/sonobuoy) to run the tests
- [ ] Use [httpexpect](github.com/gavv/httpexpect) library
- [ ] Confirm the comments in e2e tests are parseable and compatible with k/k
