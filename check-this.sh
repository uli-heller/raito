#!/bin/bash
#      ^^^^---bash! Using /bin/sh will not to the cleanup after pressing Ctrl-C
#
# check-this.sh
#
# $1 ... .tar.xz file of the distribution
#
BN="$(basename "$0")"
#BASE="$(basename "$1" .tar.xz)"
#
#test -e "${BASE}" && {
#    echo >&2 "${BN}: '${BASE}' already exists -> terminating"
#    exit 1
#}

#xz -cd "$1"|tar xf -

(
    #cd "${BASE}"
    touch *
    python3 -m http.server 8000 &
    PYTHON3_PID="$!"
    trap "kill -9 ${PYTHON3_PID}" 2 #SIGINT
    wait "${PYTHON3_PID}"
)

#rm -rf "${BASE}"
