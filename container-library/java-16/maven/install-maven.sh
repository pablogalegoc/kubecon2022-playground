#!/usr/bin/env bash

set -euo pipefail

MAVEN_VERSION=${MAVEN_VERSION:?MAVEN_VERSION must be defined}

DOWNLOAD_URL="https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz"

DEST_DIR=${DEST_DIR:-/opt/maven}
BIN_DIR="${DEST_DIR}/bin"

# shellcheck disable=SC2015
command -v wget 2>/dev/null >&2 && command -v gzip 2>/dev/null >&2 || \
  install_packages wget tar gzip

echo "[info] Installing Maven ${MAVEN_VERSION} into ${DEST_DIR}"
mkdir -p "${DEST_DIR}"

tmpfile=$(mktemp)
wget --progress=dot:mega -O "${tmpfile}" "${DOWNLOAD_URL}"
tar zxf "${tmpfile}" --strip-components=1 -C "${DEST_DIR}"
rm -f "${tmpfile}"

# Smoke tests
"${BIN_DIR}/mvn" --version
