#!/usr/bin/env bash
set -euo pipefail

java -jar "$GITHUB_WORKSPACE/dlsync.jar" \
  deploy \
  --script-root "$GITHUB_WORKSPACE/db_scripts" \
  --profile "$PROFILE"