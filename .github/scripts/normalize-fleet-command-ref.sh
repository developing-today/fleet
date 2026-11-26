#!/usr/bin/env bash
# Normalize Fleet command refs before actions/checkout. Contract: exactly one
# argument; preserve blank/default, branches, tags, and SHAs, but qualify GitHub
# pull request merge/head refs so checkout does not interpret them as branches.
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: normalize-fleet-command-ref.sh REF" >&2
  exit 2
fi

ref="$1"
if [[ "$ref" =~ ^pull/([0-9]+)/(merge|head)$ ]]; then
  ref="refs/pull/${BASH_REMATCH[1]}/${BASH_REMATCH[2]}"
fi
printf 'ref=%s\n' "$ref"
