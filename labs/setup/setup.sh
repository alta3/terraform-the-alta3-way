#!/bin/bash
set -uo pipefail

function now() {
    printf '%x' "$(date +%s%3N)"
}

# cd into the setup directory
SETUP_DIR=$(dirname "$(readlink -f "$1")")
echo $1
echo $SETUP_DIR
pushd "${SETUP_DIR}" >> /dev/null || exit 1

if [ -z ${1+x} ]; then
    echo "[-] missing lab-name, to run:"
    printf "\tsetup lab-name\n"
    exit 1
fi
LAB_ID=$1

if [ ! -d "$LAB_ID" ]; then
    echo "[-]  setup dir ${LAB_ID} not found"
    exit 1
fi

if [ ! -f "$LAB_ID/setup.sh" ]; then
    echo "[-] File ${LAB_ID}/setup.sh not found"
    exit 1
fi

# run all teardowns
echo "[+] Terraform Destroy Old Resources"
TD_LOG_DIR=$(mktemp --directory --tmpdir "teardown.${LAB_ID}.XXXX")
for f in *; do
    export WAIT="false"
    if [ "${f}" = "${LAB_ID}" ]; then
        export WAIT="true"
    fi
    if [ -d "$f" ]; then
        bash "${f}/teardown.sh" > "${TD_LOG_DIR}/$(now)_${f}_teardown.log" 2>&1 &
    fi
done
wait

# run this setup
echo "[+] Preparing ${LAB_ID}"
SETUP_LOG="/tmp/$(now)_${LAB_ID}_setup.log"
cat ${LAB_ID}/setup.sh
bash "${LAB_ID}/setup.sh" > "${SETUP_LOG}" 2>&1
if [ $? -ne 0 ]; then
    cat "${SETUP_LOG}"
    echo "[-] Setup failed"
    exit 1
fi
popd >> /dev/null || exit 1
echo "[+] Setup complete"
