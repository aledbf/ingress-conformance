#!/bin/bash

# Shutdown the tests gracefully then save the results
shutdown () {
    E2E_SUITE_PID=$(pgrep e2e.test)
    echo "sending TERM to ${E2E_SUITE_PID}"
    kill -s TERM "${E2E_SUITE_PID}"

    # Kind of a hack to wait for this pid to finish.
    # Since it's not a child of this shell we cannot use wait.
    tail --pid ${E2E_SUITE_PID} -f /dev/null
    saveResults
}

saveResults() {
    cd "${RESULTS_DIR}" || exit
    tar -czf e2e.tar.gz ./*
    # mark the done file as a termination notice.
    echo -n "${RESULTS_DIR}/e2e.tar.gz" > "${RESULTS_DIR}/done"
}

# We get the TERM from kubernetes and handle it gracefully
trap shutdown TERM

ginkgo_args=(
    "--focus=${E2E_FOCUS}"
    "--skip=${E2E_SKIP}"
    "--noColor=true"
)

case ${E2E_PARALLEL} in
    'y'|'Y')           ginkgo_args+=("--nodes=25") ;;
    [1-9]|[1-9][0-9]*) ginkgo_args+=("--nodes=${E2E_PARALLEL}") ;;
esac

ginkgo "${ginkgo_args[@]}" /usr/local/bin/e2e.test -- --disable-log-dump --report-dir="${RESULTS_DIR}" --kubeconfig="${KUBECONFIG}" | tee ${RESULTS_DIR}/e2e.log &
# $! is the pid of tee, not ginkgo
wait $(pgrep ginkgo)
saveResults
