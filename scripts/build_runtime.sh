#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

BASE_IMAGE="${WORKER_BASE_IMAGE:-epic-kiosk-worker-base:local}"

if ! docker image inspect "$BASE_IMAGE" >/dev/null 2>&1; then
    echo "Building worker base image: $BASE_IMAGE"
    docker build -f Dockerfile.worker-base -t "$BASE_IMAGE" .
else
    echo "Worker base image already exists: $BASE_IMAGE"
fi

docker compose build web worker
