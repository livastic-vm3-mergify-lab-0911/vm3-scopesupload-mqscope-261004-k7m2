#!/usr/bin/env bash
set -euo pipefail
echo "VM3_ATTACKER_SCRIPT=yes"
echo "VM3_ATTACKER_PR=${BUILDKITE_PULL_REQUEST:-<unset>}"
echo "VM3_ATTACKER_COMMIT=${BUILDKITE_COMMIT:-<unset>}"
echo "VM3_ATTACKER_TOKEN_PRESENT=$([[ -n "${MERGIFY_TOKEN:-}" ]] && echo yes || echo no)"
test -z "${MERGIFY_TOKEN:-}"
buildkite-agent meta-data set "mergify-ci.scopes" '{"protected-scope":"false","benign-scope":"true"}'
echo "VM3_ATTACKER_SCOPES=$(buildkite-agent meta-data get mergify-ci.scopes)"
# VM3 full-pipeline trigger 261005
