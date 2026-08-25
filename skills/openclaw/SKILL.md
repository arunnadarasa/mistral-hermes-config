---
name: openclaw
description: Use when running Nexus or Guppy quantum jobs on this Mac.
version: 1.0.0
metadata:
  hermes:
    tags: [openclaw, hermes, desktop, macos, venv, interpreter]
    category: productivity
    requires_toolsets: [terminal]
---

# OpenClaw — Hermes desktop environment on macOS

The OpenClaw machine is a macOS desktop (26.5.2) running the Hermes Agent
desktop app. This skill captures the environment facts that repeatedly bite:
which python has which packages, how to run Nexus/Guppy jobs, and how to
coordinate background sweeps across multiple backends.

## When to Use

Load this skill when:
- You need to run Python scripts that require `qnexus`, `guppylang`,
  `pytket`, or `selene_sim` and need the correct interpreter
- You are submitting quantum jobs to Nexus backends from this machine
- You are coordinating multiple background sweeps (H1-1LE, H2-1LE, Helios)
- You need to know which tools are installed where

## Interpreter map (CRITICAL)

| Interpreter | Path | Python | Has | Missing |
|---|---|---|---|---|
| **System python3** | `python3` (3.14) | 3.14 | guppylang 1.0.1, selene_sim, pytket 2.18.1 | qnexus, hugr_qir |
| **Hermes venv** | `/Users/openclaw/.hermes/hermes-agent/venv/bin/python` | 3.11 | qnexus, guppylang 1.0.x, selene_sim, pytket 2.18.1 | hugr_qir |
| **pip target** | `pip install` → Hermes venv | 3.11 | whatever you install | system python3 won't see it |

**Rule**: For Nexus jobs, ALWAYS use the Hermes venv python:
```bash
/Users/openclaw/.hermes/hermes-agent/venv/bin/python script.py
```

`pip install` goes to the Hermes venv (3.11), NOT system python3 (3.14).
If `python3 -c "import X"` fails after `pip install X`, use the venv python.

## Nexus backend landscape (verified 25 Aug 2026)

12 backends available via `qnx.devices.get_all()`:

| Backend | Type | Result accessor | Cost |
|---|---|---|---|
| H1-1LE | local emulator (noiseless) | `get_counts()` (pytket) | FREE |
| H2-1LE | local emulator (noiseless) | `get_counts()` (pytket) | FREE |
| H1-Emulator | noisy emulator | `get_counts()` (pytket) | FREE |
| H2-Emulator | noisy emulator | `get_counts()` (pytket) | FREE |
| Helios-1E-lite | Helios (HUGR-only) | `register_counts()` (Qsys) | FREE |
| Aer | IBM simulator | `get_counts()` (pytket) | FREE |
| Qulacs | CPU statevector | `get_counts()` (pytket) | FREE |

- Local emulators are **free** (no HQC charged)
- `attempt_batching=True` → 403 "Batching needs to be enabled for your
  organization" — just use multi-program jobs instead
- Nexus login persists (device-code flow, no re-auth needed per session)
- Project: `EndoTrack-QIR` (shared across all submissions)

## Background sweep coordination

When running multiple backend sweeps in parallel:

1. Launch each as `terminal(background=True, notify_on_complete=True)`
2. Each gets a unique `session_id` (e.g. `proc_abc123`)
3. Poll with `process(action='poll', session_id=...)` — non-blocking
4. Wait with `process(action='wait', session_id=..., timeout=120)` — blocks
5. Kill stale runs with `process(action='kill', session_id=...)`
6. Stale notifications from killed processes arrive late — check the
   `session_id` to know which run is current

## Pytket angle convention (the #1 pitfall)

pytket `Rz(param)` takes **HALFTURNS**, not radians:
- `Rz(0.5)` = rotation by π/2
- To rotate by θ radians: `circ.Rz(θ / math.pi, q)`
- Wrong convention gives error ~1.0 (complete signal inversion)
- Verify: `Circuit(1).Rz(0.5).get_unitary()` → diag(e^{-iπ/4}, e^{iπ/4})

## Verification

```bash
# Check Nexus is reachable
/Users/openclaw/.hermes/hermes-agent/venv/bin/python -c "import qnexus; qnx.devices.get_all()"

# Check Guppy + Selene
python3 -c "import guppylang, selene_sim; print('OK')"

# Check pytket
python3 -c "import pytket; print(pytket.__version__)"
```
