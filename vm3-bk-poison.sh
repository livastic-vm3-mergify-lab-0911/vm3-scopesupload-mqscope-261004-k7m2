#!/usr/bin/env bash
set -euo pipefail
echo "VM3_SAFE_ATTACKER_SCRIPT=yes"
echo "VM3_SAFE_PR=${BUILDKITE_PULL_REQUEST:-<unset>}"
echo "VM3_SAFE_COMMIT=${BUILDKITE_COMMIT:-<unset>}"
echo "VM3_SAFE_TOKEN_PRESENT=$([[ -n "${MERGIFY_TOKEN:-}" ]] && echo yes || echo no)"
test -z "${MERGIFY_TOKEN:-}"
if buildkite-agent secret get MERGIFY_TOKEN >/tmp/vm3-safe-secret 2>/tmp/vm3-safe-secret.err; then
  echo "VM3_SAFE_SECRET_GET=UNEXPECTED_ALLOWED"
  rm -f /tmp/vm3-safe-secret /tmp/vm3-safe-secret.err
  exit 94
else
  echo "VM3_SAFE_SECRET_GET=denied"
fi
rm -f /tmp/vm3-safe-secret /tmp/vm3-safe-secret.err
echo "VM3_SAFE_SCOPES=$(buildkite-agent meta-data get mergify-ci.scopes)"
