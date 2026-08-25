#!/usr/bin/env bash
# baseline-noop — the floor of the curve.
#
# Writes NO answer. Every task's checker should FAIL because there is
# nothing to assert on — proving the corpus is genuinely testing
# something (and giving the zero-effort reference point).
exit 0