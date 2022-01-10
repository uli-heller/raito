#!/bin/sh
#
# create-distributions.sh
#
#set -x
set -e
D="$(dirname "$0")"
D="$(cd "${D}" && pwd)"
BN="$(basename "$0")"

TMPDIR="/tmp/${BN}_$(openssl rand -hex 20)_$$~"

SEPARATOR=:
GITHUB_PUBKEY="$(curl -sq "https://github.com/uli-heller.keys" || exit 0)"

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

# $1 ... replace
prepareReplace () {
    cut -d: -f1 "$1" >"${TMPDIR}/f1.txt"
    cut -d: -f2 "$1" >"${TMPDIR}/f2.txt"
    cut -d: -f3 "$1" >"${TMPDIR}/f3.txt"
    sed -i -e 's/${VERSION}/'"${VERSION}/g" "${TMPDIR}/f2.txt"
    paste -d: "${TMPDIR}/f1.txt" "${TMPDIR}/f2.txt" "${TMPDIR}/f3.txt"
}

# $1 ... standard oder dp
create () {
    BASE="raito"
    test "$1" = "dp" && BASE="raito-dp"
    prepareReplace "${D}/distributions/common.replace" >"${TMPDIR}/this.replace"
    prepareReplace "${D}/distributions/$1.replace" >>"${TMPDIR}/this.replace"
    (
      cd "${D}"
      tar cf - $(cat "${D}/distributions/common.list") $(cat "${D}/distributions/$1.list")
    )|(
      mkdir -p "${TMPDIR}/${BASE}-${VERSION}"
      cd "${TMPDIR}/${BASE}-${VERSION}"
      tar xf -      
      grep -v "^#" "${TMPDIR}/this.replace" | while read line; do
	SEARCH="$(echo "${line}"|cut -d "${SEPARATOR}" -f1)"
	REPLACE="$(echo "${line}"|cut -d "${SEPARATOR}" -f2)"
	FILES="$(echo "${line}"|cut -d "${SEPARATOR}" -f3)"
	test -z "${FILES}" && FILES="."
	for f in $(find ${FILES} -type f); do
	    sed -i -e "s/${SEARCH}/${REPLACE}/g" "${f}"
	done
      done
    )
    SSH_SIG=
    ( cd "${TMPDIR}"; tar cf - "${BASE}-${VERSION}")|xz -9 >"${BASE}-${VERSION}.tar.xz"
    sha256sum "${BASE}-${VERSION}.tar.xz" >"${BASE}-${VERSION}.tar.xz.sha256"
    test -s "${TMPDIR}/ssh.pub" && {
	SSH_SIG=" and .ssh-sig"
	ssh-keygen -q -Y sign -n file -f "${TMPDIR}/ssh.pub" <"${BASE}-${VERSION}.tar.xz" >"${BASE}-${VERSION}.tar.xz.ssh-sig"
    }
    echo "Created ${BASE}-${VERSION}.tar.xz and .sha256${SSH_SIG}"
}

test -n "${GITHUB_PUBKEY}" && {
    echo "${GITHUB_PUBKEY}" >"${TMPDIR}/ssh.pub"
}

create standard
create dp

cleanUp
exit "${RC}"
