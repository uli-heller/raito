#!/bin/sh
#
# create-distributions.sh
#
set -e
D="$(dirname "$0")"
D="$(cd "${D}" && pwd)"
BN="$(basename "$0")"

TMPDIR="/tmp/${BN}_$(openssl rand -hex 20)_$$~"

SEPARATOR=:

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
    tar cf - $(cat "${D}/distributions/common.list") $(cat "${D}/distributions/standard.list")
)|(
    cd "${TMPDIR}/raito-${VERSION}"
    tar xf -
    while read line; do
	SEARCH="$(echo "${line}"|cut -d "${SEPARATOR}" -f1)"
	REPLACE="$(echo "${line}"|cut -d "${SEPARATOR}" -f2)"
	for f in *; do
	    sed -i -e "s/${SEARCH}/${REPLACE}/" "${f}"
	done
    done <"${D}/distributions/standard.replace"
)

mkdir "${TMPDIR}/raito-dp-${VERSION}"

(
    cd "${D}"
    tar cf - $(cat "${D}/distributions/common.list") $(cat "${D}/distributions/dp.list")
)|(
    cd "${TMPDIR}/raito-dp-${VERSION}"
    tar xf -
    while read line; do
	SEARCH="$(echo "${line}"|cut -d "${SEPARATOR}" -f1)"
	REPLACE="$(echo "${line}"|cut -d "${SEPARATOR}" -f2)"
	for f in *; do
	    sed -i -e "s/${SEARCH}/${REPLACE}/" "${f}"
	done
    done <"${D}/distributions/dp.replace"
)


( cd "${TMPDIR}"; tar cf - "raito-dp-${VERSION}")|xz -9 >"raito-dp-${VERSION}.tar.xz"
echo "Created raito-dp-${VERSION}.tar.xz"
( cd "${TMPDIR}"; tar cf - "raito-${VERSION}")|xz -9 >"raito-${VERSION}.tar.xz"
echo "Created raito-${VERSION}.tar.xz"

cleanUp
exit "${RC}"
