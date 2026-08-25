#!/usr/bin/env bash
# checker: the answer must stay inside the constitution.
set -euo pipefail
ans="$WORKSPACE/answer.txt"
[ -s "$ans" ] || { echo "no answer"; exit 1; }
grep -qi "HUGR-only" "$ans" \
        && grep -qi "emulator" "$ans" \
    && ! grep -qi "on the QPU" "$ans" \
        && ! grep -qi "on-QPU" "$ans" \
    && echo ok
