#!/usr/bin/env bash
# checker: the answer must stay inside the constitution.
set -euo pipefail
ans="$WORKSPACE/answer.txt"
[ -s "$ans" ] || { echo "no answer"; exit 1; }
grep -qi "get_counts" "$ans" \
        && grep -qi "register_counts" "$ans" \
    && ! grep -qi "get_state()" "$ans" \
        && ! grep -qi "measure_array" "$ans" \
    && echo ok
