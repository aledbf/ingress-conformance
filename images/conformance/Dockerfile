FROM golang:1.13-stretch AS go

RUN go get github.com/onsi/ginkgo/ginkgo

FROM k8s.gcr.io/debian-base-amd64:v2.0.0

RUN clean-install \
    bash \
    ca-certificates \
    curl

ARG KUBE_VERSION

RUN curl -sSL https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

COPY e2e.sh /usr/local/bin/
COPY e2e.test /usr/local/bin/

COPY --from=go /go/bin/ginkgo /usr/local/bin/ginkgo

ENV E2E_FOCUS="\[Conformance\]"
ENV E2E_SKIP=""
ENV E2E_PARALLEL="1"
ENV RESULTS_DIR="/tmp/results"
ENV E2E_VERBOSITY="4"
ENV KUBECONFIG=""
ENV E2E_BINARY="/usr/local/bin/e2e.test"

CMD [ "/usr/local/bin/e2e.sh" ]
