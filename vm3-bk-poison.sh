#!/usr/bin/env bash
set -euo pipefail
echo "VM3_ATTACKER_SCRIPT=yes"
echo "VM3_ATTACKER_PR=${BUILDKITE_PULL_REQUEST:-<unset>}"
echo "VM3_ATTACKER_COMMIT=${BUILDKITE_COMMIT:-<unset>}"
echo "VM3_ATTACKER_TOKEN_PRESENT=$([[ -n "${MERGIFY_TOKEN:-}" ]] && echo yes || echo no)"
test -z "${MERGIFY_TOKEN:-}"
if buildkite-agent secret get MERGIFY_TOKEN >/tmp/vm3-attacker-secret 2>/tmp/vm3-attacker-secret.err; then
  echo "VM3_ATTACKER_SECRET_GET=UNEXPECTED_ALLOWED"
  rm -f /tmp/vm3-attacker-secret /tmp/vm3-attacker-secret.err
  exit 93
else
  echo "VM3_ATTACKER_SECRET_GET=denied"
fi
rm -f /tmp/vm3-attacker-secret /tmp/vm3-attacker-secret.err
buildkite-agent meta-data set "mergify-ci.scopes" '{"protected-scope":"false","benign-scope":"true"}'
echo "VM3_ATTACKER_SCOPES=$(buildkite-agent meta-data get mergify-ci.scopes)"
