# ingress-conformance
Conformance test suite for Kubernetes Ingress (POC)

### How to run the e2e suite:

- [Local binaries](#how-to-run-tests-using-binaries)
- [Static pod](#how-to-run-tests-using-a-pod)
- [Using sonobuoy](#how-to-run-tests-using-sonobuoy)

--------

#### How to run tests using binaries

```
$ make build # build e2e.test binary
$ make test  # runs e2e suite against an existing Kubernetes cluster
             # (uses current context from KUBECONFIG)
```

--------

#### How to run tests using a pod

```
$ kubectl create -f images/conformance/conformance.yaml
```

--------


#### How to run tests using sonobuoy

The goal is to use the same approach used by the official [Kubernetes certification program](https://github.com/cncf/k8s-conformance)

The standard tool for running these tests is [Sonobuoy](https://github.com/heptio/sonobuoy).
Sonobuoy is regularly built and kept up to date to execute against all currently supported versions of kubernetes.

Download a [binary release](https://github.com/heptio/sonobuoy/releases) of the CLI, or build it yourself by running:

```
$ go get -u -v github.com/heptio/sonobuoy
```

##### run

```
$ sonobuoy run \
    --wait \
    --mode=certified-conformance \
    --kube-conformance-image=aledbf/ingress-conformance:v02062020-ac7e541
```

##### Retrieve results and check for failed tests

```
$ results=$(sonobuoy retrieve)
```

```
$ sonobuoy e2e $results
```

##### Cleanup

```
$ sonobuoy delete --wait
```

--------

**TODO:**

- [X] Build docker image
- [X] Confirm the suite runs in a pod
- [X] Use [Sonoboy](https://github.com/vmware-tanzu/sonobuoy) to run the tests
- [ ] Use [httpexpect](github.com/gavv/httpexpect) library
- [X] Confirm the comments in e2e tests are parseable and compatible with k/k
