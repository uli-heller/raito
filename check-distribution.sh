#!/bin/sh
#
# check-distribution.sh
#
# $1 ... .tar.xz file of the distribution
#
BASE="$(basename "$1" .tar.xz)"

test -e "${BASE}" && {
    echo >&2 "${BN}: '${BASE}' already exists -> terminating"
    exit 1
}

xz -cd "$1"|tar xf -

(
    cd "${BASE}"
    trap '' SIGINT
    python3 -m http.server 8000
)

rm -rf "${BASE}"
