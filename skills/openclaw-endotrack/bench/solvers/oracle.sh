#!/usr/bin/env bash
# oracle — the ceiling of the curve.
#
# Writes the canonical honest answer for the task ($TASK_DIR/oracle.sh)
# into the workspace. Every task's checker should PASS, proving the
# checkers recognise a constitution-compliant answer. A real agent
# solver's job is to close the floor->ceiling gap — with the skill
# loaded, it should land at the ceiling.
set -euo pipefail
exec bash "$TASK_DIR/oracle.sh"