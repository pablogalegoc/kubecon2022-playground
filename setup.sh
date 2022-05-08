#!/bin/sh
mkdir -p ./trivy-cache/db/
tar -C ./trivy-cache/db/ -xzf ./utils/trivy-db-36ece5d0500a9e8ab56053bb702ca67a5f9956234a5a5b5325d7f4f824dbbd2e.tar.gz
export EMAIL=myemail@kube.con AUTH=ups-this-is-a-secret TRIVY_CACHE_DIR=trivy-cache TRIVY_SKIP_DB_UPDATE=true TRIVY_QUIET=true
