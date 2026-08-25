#!/usr/bin/env bash
set -euo pipefail
cat > "$WORKSPACE/answer.txt" <<'EOF'
Qulacs BackendResult (ResultType.PYTKET) → get_counts(). SelenePlus QsysResult → register_counts() (or collated_digitstring_counts). Separate lanes: Qulacs runs in the /tmp/qir021_venv (guppylang 0.21.16) with pytket 2.18.1; the SUBSTRATE lane (system python, guppylang 1.0.1) uses array-form readout via collect_measurements — never cross the lanes.
EOF
