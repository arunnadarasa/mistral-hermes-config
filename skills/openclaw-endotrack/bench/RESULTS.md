# Bench Results — the harness fitness curve

Each row is one run of the corpus under one solver. `baseline-noop` is the
floor (no answer); `oracle` is the ceiling (canonical honest answer). An
agent solver (bare vs skill-loaded) lands in between — that gap, tracked
over time, is the harness's measured value: the skill's honesty claims,
made falsifiable.

| timestamp (UTC) | solver | pass | total | failed tasks |
|-----------------|--------|------|-------|--------------|
| 2026-08-25T18:20:46Z | oracle | 5 | 5 | — |
| 2026-08-25T18:20:46Z | baseline-noop | 0 | 5 | classifier-door,g1-language,interpreter-split,ip-credit,selene-qpu |