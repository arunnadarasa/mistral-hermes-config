# bench — the skill's honesty fitness function

This skill claims the agent **stays inside the project constitution** when
answering EndoTrack questions: it never claims a closed classifier door,
never calls the G1 reduction unitary, never says SelenePlus ran on a QPU,
never miscredits IP, never crosses the interpreter lanes. Those are
strong claims. `bench` makes them **falsifiable**.

Every corpus task in `corpus/` is an **honesty trap**: a prompt engineered
to tempt a constitution violation. A solver writes `answer.txt`; the
task's `check.sh` asserts required phrases are present and forbidden
phrases are absent — an objective checker, exit 0 = pass.

## How it works

```
corpus/<task>/prompt.txt    the trap prompt
corpus/<task>/check.sh      objective checker — exit 0 = pass (the metric)
corpus/<task>/oracle.sh     the canonical honest answer (defines the ceiling)
corpus/<task>/task.yaml     metadata: failure_mode, skill_under_test, expectations
solvers/<name>.sh           pluggable "who attempts the task"
runner/run-bench.sh         run -> check -> score -> record
RESULTS.md                  append-only ledger: the curve over time
```

## The curve

| solver | expected | meaning |
|--------|----------|---------|
| `baseline-noop` | 0 / N | the **floor** — proves the traps are real (no answer never passes) |
| `oracle` | N / N | the **ceiling** — proves checkers recognise a constitution-compliant answer |
| *(future)* `agent-bare` | between | a real agent, no skill loaded |
| *(next)* `agent-inner` | higher? | the same agent + the endotrack skill — **the measured value of the skill** |

The gap from floor to agent-bare to agent-inner, tracked in RESULTS.md, is
the harness's whole point: the skill's honesty claim, tested — not argued.

## Run it

```bash
bench/runner/run-bench.sh --solver baseline-noop --record  # floor
bench/runner/run-bench.sh --solver oracle --record         # ceiling
bench/runner/run-bench.sh --solver oracle --task g1-language
```

Only `bash` + standard tools required. No network, fully deterministic.

## Add a trap

A new task needs: a prompt that tempts a specific violation, an oracle
(the honest answer), and a checker (required/forbidden phrases). The
generator that produced the original five lives in the repo as
`tools/gen_bench_corpus.py` — extend the `TASKS` dict and re-run.