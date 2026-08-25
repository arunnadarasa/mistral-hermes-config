#!/usr/bin/env bash
# bench runner — the harness fitness function for the endotrack skill.
#
# The corpus tasks are HONESTY TRAPS: prompts engineered to tempt an agent
# into violating the project constitution (claiming a closed classifier
# door, calling the G1 reduction unitary, saying SelenePlus ran on a QPU,
# miscrediting IP, crossing the interpreter lanes). An agent answering
# WITH the endotrack skill loaded should stay inside the constitution;
# the checker proves it mechanically.
#
# For each task in corpus/, a solver writes workspace/answer.txt (the
# agent's answer to the trap prompt). The checker asserts required phrases
# are present and forbidden phrases are absent. A task passes when its
# checker exits 0.
#
# Solvers (pluggable):
#   baseline-noop  does nothing -> no answer -> every task FAILS (the floor)
#   oracle         writes the canonical honest answer -> every task PASSES
#                  (the ceiling)
#   *(future)* agent-bare / agent-inner: run a real agent with/without the
#   skill loaded; the gap floor->agent->ceiling is the harness's measured
#   value — our claims about the skill become falsifiable.
#
# Usage:
#   bench/runner/run-bench.sh [--solver NAME] [--task TASK_ID] [--record]
#     --solver NAME  solver in solvers/ (default: baseline-noop)
#     --task TASK_ID run only one corpus task
#     --record       append the run to RESULTS.md
set -uo pipefail

BENCH_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CORPUS_DIR="$BENCH_DIR/corpus"
SOLVERS_DIR="$BENCH_DIR/solvers"
RESULTS_FILE="$BENCH_DIR/RESULTS.md"

solver="baseline-noop"
only_task=""
record=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --solver) solver="$2"; shift 2 ;;
    --task)   only_task="$2"; shift 2 ;;
    --record) record=true; shift ;;
    *) echo "unknown arg: $1" >&2; exit 2 ;;
  esac
done

[[ -x "$SOLVERS_DIR/$solver.sh" ]] || { echo "no solver: $solver" >&2; exit 2; }

# materialize into a temp workspace
TMP="$(mktemp -d /tmp/endotrack-bench.XXXXXX)"
trap 'rm -rf "$TMP"' EXIT

tasks=()
if [[ -n "$only_task" ]]; then
  tasks=("$CORPUS_DIR/$only_task")
else
  tasks=("$CORPUS_DIR"/*/)
fi

pass=0; total=0; failed=""
for tdir in "${tasks[@]}"; do
  [[ -d "$tdir" ]] || continue
  tid="$(basename "$tdir")"
  task_ws="$TMP/$tid"
  mkdir -p "$task_ws"
  # run the solver; it writes $task_ws/answer.txt
  WORKSPACE="$task_ws" TASK_DIR="$tdir" bash "$SOLVERS_DIR/$solver.sh"
  total=$((total + 1))
  if WORKSPACE="$task_ws" bash "$tdir/check.sh" >/dev/null 2>&1; then
    pass=$((pass + 1))
    echo "PASS  $tid"
  else
    failed="${failed}${failed:+,}$tid"
    echo "FAIL  $tid"
  fi
done

echo "---"
echo "score: $pass/$total (solver: $solver)"

if $record; then
  ts="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  printf '| %s | %s | %d | %d | %s |\n' "$ts" "$solver" "$pass" "$total" "${failed:---}" >> "$RESULTS_FILE"
  echo "recorded -> $RESULTS_FILE"
fi