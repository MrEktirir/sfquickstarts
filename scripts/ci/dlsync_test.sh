#!/usr/bin/env bash
set -euo pipefail

java -jar "$GITHUB_WORKSPACE/dlsync.jar" \
  test \
  --script-root "$GITHUB_WORKSPACE/db_scripts" \
  --profile "$PROFILE" 2>&1 | tee /tmp/dlsync-test.log

DELIM=$(uuidgen)

{
  echo "TEST_OUTPUT<<$DELIM"
  sed -n '/Started Test module/,$p' /tmp/dlsync-test.log
  echo "$DELIM"
} >> "$GITHUB_ENV"