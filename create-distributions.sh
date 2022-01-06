#!/bin/sh
#
# create-distributions.sh
#
set -e
D="$(dirname "$0")"
D="$(cd "${D}" && pwd)"
BN="$(basename "$0")"

TMPDIR="/tmp/${BN}_$(openssl rand -hex 20)_$$~"

RC=0
cleanUp () {
    rm -rf "${TMPDIR}"
    exit "$RC"
}

trap cleanUp 0 1 2 3 4 5 6 7 8 9 10 12 13 14 15

BRANCH="$(git branch --show-current)"
VERSION="$(git describe --tags)"

mkdir -p "${TMPDIR}"

mkdir "${TMPDIR}/raito-${VERSION}"

(
    cd "${D}"
    tar cf - $(cat "${D}/distributions/common") $(cat "${D}/distributions/standard")
)|(
    cd "${TMPDIR}/raito-${VERSION}"
    tar xf -
)

mkdir "${TMPDIR}/raito-dp-${VERSION}"

(
    cd "${D}"
    tar cf - $(cat "${D}/distributions/common") $(cat "${D}/distributions/dp")
)|(
    cd "${TMPDIR}/raito-dp-${VERSION}"
    tar xf -
)

( cd "${TMPDIR}"; find . )

cleanUp
exit "${RC}"
