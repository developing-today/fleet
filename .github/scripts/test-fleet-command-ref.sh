#!/usr/bin/env bash
# Regression coverage for PR refs passed to actions/checkout by fleet-command.
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
normalize="$here/normalize-fleet-command-ref.sh"
action="$here/../actions/fleet-command/action.yml"

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

expect_ref() {
  local input="$1" expected="$2" actual
  actual="$(bash "$normalize" "$input")"
  [ "$actual" = "ref=$expected" ] || fail "input '$input': expected 'ref=$expected', got '$actual'"
}

expect_ref "pull/15250/merge" "refs/pull/15250/merge"
expect_ref "pull/15250/head" "refs/pull/15250/head"
expect_ref "feature/example" "feature/example"
expect_ref "release-1.2" "release-1.2"
expect_ref "0123456789abcdef0123456789abcdef01234567" "0123456789abcdef0123456789abcdef01234567"
expect_ref "" ""

if bash "$normalize" >/dev/null 2>&1; then
  fail "normalizer accepted a missing argument"
fi
if bash "$normalize" one two >/dev/null 2>&1; then
  fail "normalizer accepted extra arguments"
fi

grep -Fq 'bash "$GITHUB_WORKSPACE/.github/scripts/normalize-fleet-command-ref.sh" "$TARGET_REF" >> "$GITHUB_OUTPUT"' "$action" ||
  fail "fleet-command action does not use the tested ref normalizer"
grep -Fq 'ref: ${{ steps.target-ref.outputs.ref }}' "$action" ||
  fail "target checkout does not consume the normalized ref"
grep -Fq 'id: target-checkout' "$action" ||
  fail "target checkout step has no outcome id"
grep -Fq 'name: Report target checkout failure' "$action" ||
  fail "checkout failures are not reported separately"
grep -Fq 'target command did not run.' "$action" ||
  fail "checkout failure report does not state that the command did not run"
grep -Fq 'Fleet target checkout failed' "$action" ||
  fail "checkout failure is missing an explicit summary/log marker"

echo "PASS: fleet-command target refs are normalized and checkout failures are explicit"
