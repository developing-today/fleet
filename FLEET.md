# The fleet — canonical repo list and management tiers

This file is the single canonical home of the fleet list: every repo the
fleet touches, its umbrella submodule path in this repo, and the management
tier accepted for it.

- Census: developing-today/code#2017 (fleet expansion census).
- Execution issue: developing-today/code#2230.
- Tier decision: Drew, 2026-11-14 (pending-decisions ledger item
  `fleet-tiers-2230`, answered via decisions-page) — accept the census
  recommendations: **kaneo FULL; cairn, zettel, nix-cache FULL-lite; the
  rest umbrella + autocommit only.**
- Recorded: 2026-11-16 by the repo queue worker (task 17433), completing
  the #2230 remainder. Umbrella set verified against the census candidate
  list the same day: 22 of 22 census candidates are submodules of this
  repo (12 pre-existing, 10 added in the same change as this file).

## Tiers

- **FULL** — label taxonomy, backlog, and queue/sweep coverage, like the
  four pilot repos.
- **FULL-lite** — label taxonomy and backlog; sweep coverage without a
  dedicated queue stream.
- **Umbrella + autocommit** — tracked as a submodule of this repo and
  covered by autocommit; no labels/backlog/queue coverage.

## Canonical list

| Repo | Submodule path | Tier |
|---|---|---|
| developing-today/code | `code` | umbrella + autocommit (pre-existing full repo-health coverage) |
| developing-today-forks/opencode | `opencode` | umbrella + autocommit (pre-existing full repo-health coverage) |
| developing-today-forks/openchamber | `openchamber` | umbrella + autocommit (pre-existing full repo-health coverage) |
| dezren39/darwin-nix | `nix` | umbrella + autocommit (pre-existing full repo-health coverage) |
| developing-today/kaneo | `kaneo` | **FULL** |
| dezren39/cairn | `cairn` | **FULL-lite** |
| developing-today/zettel | `zettel` | **FULL-lite** |
| dezren39/zettel | `dezren39-zettel` | **FULL-lite** (same project, personal-org copy — see note) |
| developing-today/nix-cache | `nix-cache` | **FULL-lite** |
| dezren39/hatch | `hatch` | umbrella + autocommit |
| dezren39/hatch-personal | `hatch-personal` | umbrella + autocommit |
| developing-today/.github | `org-readme` | umbrella + autocommit |
| developing-today/zulip-archive | `zulip-archive` | umbrella + autocommit |
| developing-today/hardware-doc | `hardware-doc` | umbrella + autocommit |
| dezren39/openclaw-personal | `openclaw-personal` | umbrella + autocommit |
| dezren39/cairn-private | `cairn-private` | umbrella + autocommit |
| dezren39/hatch-drawer | `hatch-drawer` | umbrella + autocommit |
| dezren39/hatch-personal-drawer | `hatch-personal-drawer` | umbrella + autocommit |
| dezren39/opencode-muse | `opencode-muse` | umbrella + autocommit |
| developing-today/opencode-auto-continue | `opencode-auto-continue` | umbrella + autocommit |
| dezren39/dezren39 | `dezren39` | umbrella + autocommit |
| dezren39/muse-esp32-screen | `muse-esp32-screen` | umbrella + autocommit |

## Notes

- **Two zettel submodules.** The census names "zettel" once, but the
  umbrella already carried both `developing-today/zettel` (path `zettel`)
  and `dezren39/zettel` (path `dezren39-zettel`) before this change. Both
  are recorded as FULL-lite here; collapsing them to one canonical repo
  is a separate decision, not part of the #2230 remainder.
- Tier changes are Drew decisions recorded on code#2230 / the
  pending-decisions ledger; edit this file in the same PR that enacts a
  tier change so the list never drifts from reality.
