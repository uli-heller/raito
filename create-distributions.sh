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

(
    cd "${D}"
    tar cf - $(cat "${D}/distributions/common.list") $(cat "${D}/distributions/standard.list")
)|(
    cd "${TMPDIR}/raito-${VERSION}"
    tar xf -
    grep -v "^#" "${D}/distributions/standard.replace" | while read line; do
	SEARCH="$(echo "${line}"|cut -d "${SEPARATOR}" -f1)"
	REPLACE="$(echo "${line}"|cut -d "${SEPARATOR}" -f2)"
	FILES="$(echo "${line}"|cut -d "${SEPARATOR}" -f3)"
	test -z "${FILES}" && FILES="."
	for f in $(find ${FILES} -type f); do
	    sed -i -e "s/${SEARCH}/${REPLACE}/g" "${f}"
	done
    done
)

mkdir "${TMPDIR}/raito-dp-${VERSION}"

(
    cd "${D}"
    tar cf - $(cat "${D}/distributions/common.list") $(cat "${D}/distributions/dp.list")
)|(
    cd "${TMPDIR}/raito-dp-${VERSION}"
    tar xf -
    grep -v "^#" "${D}/distributions/dp.replace" | while read line; do
	SEARCH="$(echo "${line}"|cut -d "${SEPARATOR}" -f1)"
	REPLACE="$(echo "${line}"|cut -d "${SEPARATOR}" -f2)"
	FILES="$(echo "${line}"|cut -d "${SEPARATOR}" -f3)"
	test -z "${FILES}" && FILES="."
	for f in $(find ${FILES} -type f); do
	    sed -i -e "s/${SEARCH}/${REPLACE}/g" "${f}"
	done
    done
)

test -n "${GITHUB_PUBKEY}" && {
    echo "${GITHUB_PUBKEY}" >"${TMPDIR}/ssh.pub"
}

SSH_SIG=
( cd "${TMPDIR}"; tar cf - "raito-dp-${VERSION}")|xz -9 >"raito-dp-${VERSION}.tar.xz"
sha256sum "raito-dp-${VERSION}.tar.xz" >"raito-dp-${VERSION}.tar.xz.sha256"
test -s "${TMPDIR}/ssh.pub" && {
    SSH_SIG=" and .ssh-sig"
    ssh-keygen -q -Y sign -n file -f "${TMPDIR}/ssh.pub" <"raito-dp-${VERSION}.tar.xz" >"raito-dp-${VERSION}.tar.xz.ssh-sig"
}
echo "Created raito-dp-${VERSION}.tar.xz and .sha256${SSH_SIG}"

SSH_SIG=
( cd "${TMPDIR}"; tar cf - "raito-${VERSION}")|xz -9 >"raito-${VERSION}.tar.xz"
sha256sum "raito-${VERSION}.tar.xz" >"raito-${VERSION}.tar.xz.sha256"
test -s "${TMPDIR}/ssh.pub" && {
    SSH_SIG=" and .ssh-sig"
    ssh-keygen -q -Y sign -n file -f "${TMPDIR}/ssh.pub" <"raito-${VERSION}.tar.xz" >"raito-${VERSION}.tar.xz.ssh-sig"
}
echo "Created raito-${VERSION}.tar.xz and .sha256${SSH_SIG}"

cleanUp
exit "${RC}"
