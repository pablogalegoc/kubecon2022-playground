#!/bin/bash
set -euo pipefail

PLUGINS_TARGET_DIR=${PLUGINS_TARGET_DIR:-/plugins}

mkdir -p "$PLUGINS_TARGET_DIR"
# Cheap way of substituting a Maven command to get a JAR from a repository
curl -L https://github.com/pablogalegoc/kubecon2022-playground/releases/download/release%2Fhello-plugin%2F0.1.0/hello-plugin-plugin-0.1.0-with-dependencies.jar --output "${PLUGINS_TARGET_DIR}/hello-plugin-plugin-0.1.0-with-dependencies.jar"
