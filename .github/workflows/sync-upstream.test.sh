#!/usr/bin/env bash
# Regression test for the sync-upstream scope guard (dezren39/fleet#87).
#
# The daily pull mints a developing.today app (5454422) token from the
# FLEET_APP_PRIVATE_KEY secret. That pairing can only authenticate in
# the two App-mirror forks (developing-today/fleet and
# developing-today-forks/fleet): the app is installed only on the
# developing.today orgs, those repos hold the matching repo-level key,
# and their branch rulesets bypass only that app. Every other fork is
# kept current by the central sync-forks push instead, so the job must
# stay guarded to exactly those two repositories — an upstream-only
# guard re-arms a daily job that can only fail on ~100 forks.
set -euo pipefail
cd "$(dirname "$0")"
f=sync-upstream.yml

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

grep -Fq "if: github.repository == 'developing-today/fleet' || github.repository == 'developing-today-forks/fleet'" "$f" ||
  fail "job guard must scope the pull to the two App-mirror forks (#87)"

if grep -Fq "github.repository != 'dezren39/fleet'" "$f"; then
  fail "old upstream-only guard is back: the pull would run on forks where it cannot authenticate (#87)"
fi

grep -Fq "app-id: 5454422" "$f" ||
  fail "app-id must stay 5454422 (the developing.today app the mirror rulesets bypass)"

grep -Fq "secrets.FLEET_APP_PRIVATE_KEY" "$f" ||
  fail "the token mint must keep reading FLEET_APP_PRIVATE_KEY"

grep -Fq "SCOPE (#87)" "$f" ||
  fail "the header must keep the #87 scope note explaining the guard"

echo "ok: sync-upstream is scoped to the two App-mirror forks (#87)"
