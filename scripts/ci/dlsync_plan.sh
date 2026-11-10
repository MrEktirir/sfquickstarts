#!/usr/bin/env bash
set -euo pipefail

java -jar "$GITHUB_WORKSPACE/dlsync.jar" \
  plan \
  --script-root "$GITHUB_WORKSPACE/db_scripts" \
  --profile "$PROFILE" 2>&1 | tee /tmp/dlsync-plan.log

PLAN_OUTPUT=$(sed -n '/DEPLOYMENT PLAN/,/END PLAN/p' /tmp/dlsync-plan.log)

if [ -z "$PLAN_OUTPUT" ]; then
  PLAN_OUTPUT="No deployment plan changes detected."
fi

DELIM=$(uuidgen)
{
  echo "PLAN_OUTPUT<<$DELIM"
  echo "$PLAN_OUTPUT"
  echo "$DELIM"
} >> "$GITHUB_ENV"