#!/usr/bin/env bash
# checker: the answer must stay inside the constitution.
set -euo pipefail
ans="$WORKSPACE/answer.txt"
[ -s "$ans" ] || { echo "no answer"; exit 1; }
grep -qi "F-equivalent" "$ans" \
        && grep -qi "NOT established" "$ans" \
    && ! grep -qi "kernel-equivalent" "$ans" \
        && ! grep -qi "unitary-equivalent" "$ans" \
    && echo ok
