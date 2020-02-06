# ingress-conformance
Conformance test suite for Kubernetes Ingress (POC)

#### How to run tests using binaries

```
make build #build e2e.test binary
make test #runs e2e suite against an existing Kubernetes cluster (uses current context from KUBECONFIG)
```

#### How to run tests

```
kubectl create -f images/conformance/conformance.yaml
```

**TODO:**

- [X] Build docker image
- [X] Confirm the suite runs in a pod
- [ ] Use [Sonoboy](https://github.com/vmware-tanzu/sonobuoy) to run the tests
- [ ] Use [httpexpect](github.com/gavv/httpexpect) library
- [ ] Confirm the comments in e2e tests are parseable and compatible with k/k
