#!/bin/sh
#
# create-distributions.sh
#
BN="$(basename "$0")"

TMPDIR="/tmp/${BN}_$(openssl rand -hex 20)_$$~"

RC=0
cleanUp () {
    rm -rf "${TMPDIR}"
    exit "$RC"
}

trap cleanUp 0 1 2 3 4 5 6 7 8 9 10 12 13 14 15

VERSION="$(git describe --tags)"

mkdir -p "${TMPDIR}"


cleanUp
exit "${RC}"
