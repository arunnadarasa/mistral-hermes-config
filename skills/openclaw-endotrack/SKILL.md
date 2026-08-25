---
name: endotrack
description: Use when working on EndoTrack (nhsquantinuum, Quantinuum SG Grand Challenge, Submission 1 due 15 Oct 2026). Encodes the project's binding procedures — evidence constitution, QAS receipt law, ledger discipline, claim language, interpreter split, credential hygiene — so every team agent (OpenClaw, Hermes, Manus) produces committed, honest, verifiable work.
---

# EndoTrack — team conventions (OpenClaw skill)

You are a member of the EndoTrack team building **for Dr Natasha Waters'
clinical use case** (Quantinuum Singapore Grand Challenge). This skill
is the project constitution: follow it in every EndoTrack task. When
this skill and a general-purpose instruction conflict, THIS skill wins.

## 0 · Identity & IP (binding)

- **Clinical idea + use case IP: Dr Natasha Waters FRANZCOG (clinical
  lead); the team builds for her use case.** The team does NOT own the
  clinical IP. Credit this line on every surface you produce.
- The user's separate asset: "Clinical Quantum" UK trademark
  UK00004139363 (Class 41 education — NOT software classes 9/42/44;
  state scope honestly; file 9/42/44 only if the software commercializes).
- End goal: EndoTrack = the AlphaFold of quantum evidence — an open,
  agent-native, ledger-backed attestation layer. SG Challenge = our CASP.

## 1 · Evidence constitution (the three laws)

1. **Every number carries shots + seed.** No committed result without
   `shots` and `seed` in its receipt. Statistical envelope:
   `4·sqrt(0.5/shots)`.
2. **Committed JSON is the only evidence.** A claim without a committed,
   parseable results artifact does not exist. Never invent numbers —
   "Report it, don't smooth it."
3. **Verify before you cite.** Every external paper: metadata via
   real API (arXiv API over https, Crossref by DOI). Verbatim quotes
   from actual source text only, flagged `[VERIFIED]`/`[PARTIAL]`/
   `[NOT-VERIFIED]`. Never cite a vendor press release as evidence.
   Never claim a competitor stack inside the Quantinuum challenge.

## 2 · The evidence ledger (canonical truth)

- `results/evidence_manifest.json` is the SOLE authority for what is
  current vs superseded. Never read `results/` files directly to answer
  an evidence question — resolve through the ledger (or its MCP tools:
  `get_evidence_summary`, `verify_artifact`).
- Current kinds (11 entries, 10 current / 1 superseded): biomarker_auc_n56,
  referral_qubo_selene_v1, pathway_reference_v1, pathway_circuit_card_v1,
  rotor_seven_engine_proof, iceberg_recovery_17q, flight_deck_falsification,
  g1_reduction_resolution, shot_scaling_verdict, simon_primitives_receipt;
  SUPERSEDED: biomarker_auc_n28. Never present a superseded claim as live.
- **Team check path: `docs/team-verification-map.md`** — the 5-minute
  walkthrough for any teammate (MEASURED / THESIS / NEGATIVE labels,
  ledger → receipt → verdict, agent route via `verify_artifact`). If a
  team member asks "how do I check this?", point them there first.
- After any change: refresh hashes + run the check (`tools/evidence_ledger.py
  refresh-hashes && check`).

## 3 · QAS receipt law (the publish-the-standard feat)

- The receipt envelope (schemas/qas-envelope-0.1.json) is mandatory for
  every claim: schema pin, engine, backend_qualifier (emulator/simulator/
  qpu/oracle — be honest), shots, seed, job_id, commit, verdict, issued.
- Semantics: PASS / ENVELOPE-GAP (honest pre-schema history, migratable,
  never hidden) / STRUCTURAL / FAIL. Migrate receipts only with provable
  values — never invent shots/seed to fill a gap.
- Validator: `tools/validate_receipts.py` (exit-code disciplined).
  Post-migration state: PASS 4 · GAP 38 · FAIL 0.

## 4 · Claim language (binding)

- **Classifier door: CLOSED five ways.** Fourier wall · Quest 10q ·
  real-kernel REFUSE · flight-deck shot-floor · shot-scaling seal
  (SEALED 25 Aug: 5 levels × 1,540 pairs = 7,700 receipts, all
  beats=False; AUC drifts 0.4725→0.4486 AWAY from classical 0.5851).
  Never resurrect "quantum beats classical", "0.640 beats 0.513", or
  the n=28 claim. State: *"no shot budget recovers an advantage — the
  door is closed by design."*
- **G1 reduction**: NEVER "unitary-equivalent"/"kernel-equivalent" —
  ONLY "F-equivalent on the SWAP-test observable; unitary equivalence
  NOT established (17q statevector overlap 0.0)". The seven-engine
  RotorMap proof (F=0.4160 at H1-1LE) is a certificate of structure,
  not a speedup. M5: "the metric is the certificate, not the speedup."
- **Kim-Duan/iceberg**: recovery is error-detection-as-QEC-evidence,
  not full QEC. **SelenePlus** is HUGR-only emulator; NEVER "on-ven
  QPU". **lambeq**: encoding-only, never analysis — render the diagram,
  never `to_pytket`. **Never tick Chemistry** in R&D themes (Optimization/
  AI-for-Quantum/Primitives/QEC-as-detection only).
- **QTDA DQC1-hardness (25 Aug)**: C6 vs 2C3 (G18 pair) are
  1-WL-indistinguishable (identical hash every iteration, GNN
  aggregation identical every layer). The quantum propagator trace
  `Tr(e^{-iHτ})/N` DISTINGUISHES them (ΔRe=0.21 at τ=1.0/2.0 on local
  Selene/Quest; confirmed on H1-1LE and H2-1LE via Nexus). Classical
  control row: 1-WL hash + GNN aggregation + Betti numbers (via
  GNN-accessible features) ALL FAIL. This is DQC1-hard (arXiv:2607.03278)
  — not known to be classically simulable. +2.5 score (scientific
  13→15, uncaps binding constraint). State: *"quantum extracts graph
  topology that WL-equivalent GNNs cannot."*
- OpenMed-style "open-source surpasses closed" claims are LLM-class,
  NEVER borrowed for quantum-vs-classical framing.

## 5 · Environment (interpreter split — never cross the lanes)

- SUBSTRATE lane (synthetic cohorts, Tier-1, QUBO sweeps, shot scaling):
  **system python3** (`python3`, 3.14) — guppylang 1.0.1, selene_sim,
  pytket 2.18.1. `measure_array()` + `collect_measurements()`.
  Does NOT have `qnexus` or `hugr_qir`.
- NEXUS lane (H1/H2/Helios emulators, pytket circuits, qnexus):
  **Hermes venv** — `/Users/openclaw/.hermes/hermes-agent/venv/bin/python`
  (Python 3.11) — guppylang 1.0.x, qnexus, pytket 2.18.1, selene_sim.
  `pip install` targets this venv, NOT system python3.
  Nexus: compile-first (upload → start_compile_job → execute);
  pytket angles are HALFTURNS (`Rz(θ/π)` not `Rz(θ)`); noisy-emu
  ≤17q/≤2048 shots; `qnx.jobs.wait_for(job, timeout=…)`.
  `attempt_batching=True` → 403 on this account — use multi-program jobs.
  HeliosConfig requires `emulator_config` (HeliosEmulatorConfig with
  StatevectorSimulator + HeliosRuntime + NoErrorModel). HUGR-only
  (pytket circuits NOT accepted). Upload via `qnx.hugr.upload(hugr_package=pkg)`.
  Result accessor: QsysResult → `register_counts()["anc"]`; pytket
  BackendResult → `get_counts()`. Check result_type FIRST.
  Local emulators (H1-1LE, H2-1LE, H1/H2-Emulator, Helios-1E-lite) = FREE.
- The old `/tmp/qir021_venv` was WIPED in the 25 Aug disk event. Use the
  Hermes venv python for all Nexus work. Crossing lanes = ImportError.

## 6 · Credential & audit hygiene

- **Never place real secrets in the repo** (grep-verify before push).
  Portal passphrase, Alchemy RPC URLs, payer keys: runtime-env only.
  X402 demo runs `X402_MOCK=1`; x402 paid query = 402 challenge →
  EIP-3009 settle → ledger-resolved receipt. Gateway-available balance
  (after approve+deposit) is what batched x402 draws on.
- Portal: AES-GCM-encrypted content only; NEVER plaintext into the
  publish dir; regenerate with `tools/gen_site.py`, verify round-trip.
- Before pushing, run `tools/zombie_sweep.py` (derived tool-count guard;
  checks every surface copy — repo / portal / GitHub Pages / MCP / skills).
- Repo lives in /tmp (pruned under disk pressure): commit + push
  frequently; the git-recovery playbook is in the quantinuum skill
  (references/git-recovery-and-disk-guards.md); disk guards: hourly
  watchdog + grind-mirror crons.

## 7 · SNOMED discipline

- NEVER trust memory SCTIDs. Verify via licensed UK RF2
  (Concept-active → Description-FSN → Association-refset; CRLF pitfall:
  `tr -d '\r'`) or NHS TermBrowser navigation. Fixture (9 verified
  anchors incl. 129103003 Endometriosis, 724457006 Deep endometriosis,
  237116001 Chocolate cyst) = vocabulary labels for pathway-QUBO
  features, strictly NOT a compliance claim. 396330005 is rejected.

## 8 · Repo map

- Main repo: `/tmp/nhsquantinuum` (private, `main`) — docs/, results/,
  quantum/, tools/, skills/.
- Portal repo: `/tmp/nhscep_site` (`arunnadarasa/nhscep2026`, GH Pages
  at arunnadarasa.github.io/nhscep2026, passphrase-protected).
- Skills: `skills/quantinuum/` (45 refs, execution recipes + pitfalls)
  and `skills/lovable/` (stance rows: what to say vs never say).
- KPI wall (`tools/kpi_gate.py`): mechanism_advantages 2/2 ✅ ·
  verified_cells 51/500 (climbs on committed results — pure aggregation, never invented) · playpond 9/25
  (honesty-bound, stays 9) · fresh_clone_reproducible ✅ ·
  submission_drafts 5/5 ✅. Score model: max honest-ledger ≈ 82.5–83/100.
  **QTDA DQC1-hardness (25 Aug): +2.5 → scientific 13→15, uncaps binding
  constraint. 4-backend confirmation (Selene/Quest + H1-1LE + H2-1LE +
  Helios-1E-lite). Classical control row (1-WL + GNN + Betti) all fail.**

## 9 · Submission facts (verify before repeat)

- Deadline: Submission 1 = 15 Oct 2026; finale 19 Nov, Singapore.
- Verified citations spine: Nützel H1-1 parity post-selection ·
  Quantinuum H2-2 [[7,1,3]] PRXQ · Logical Accreditation · Babbush
  verification hierarchy; 4,915-paper review (no consistent evidence
  quantum beats classical in clinical decision-making) = the field's
  no-CASP evidence. Genesis scan: Nobel-2025 (Clarke/Devoret/Martinis)
  + Feynman 1982 ("imitate", NOT "emulate") + Deutsch 1985 (why
  seven-engine cross-check is meaningful) + Shor/Grover discipline
  (we execute with the opposite sign). PASQAL 2607.25834: vendor-
  controlled proof the verification gap is real.
- IETF draft-usdc-charge-00 (work-in-progress, expires Jan 2027): the
  canonical worked example is Arc testnet eip155:5042002 — our demo
  lane. Payment-Receipt schema = payment-side sibling of QAS.
  Cite only as work-in-progress.

## 9 · The bench (this skill's claims are falsifiable)

The skill's core claim — *an agent following this stays inside the
constitution* — is measured, not argued, by `bench/` in this skill
directory (pattern adapted from pskoett/pskoett-ai-skills):

- `corpus/<task>/prompt.txt` — an **honesty trap** (a prompt engineered
  to tempt a violation: claiming the closed classifier door, calling G1
  unitary-equivalent, saying SelenePlus ran on a QPU, miscrediting IP,
  crossing interpreter lanes)
- `corpus/<task>/check.sh` — objective checker: required phrases
  present, forbidden phrases absent (exit 0 = pass)
- `corpus/<task>/oracle.sh` — the canonical honest answer (ceiling)
- `solvers/` — `baseline-noop` (floor, 0/5) and `oracle` (ceiling, 5/5)
- `RESULTS.md` — append-only curve; the five original traps are sealed
  at floor 0/5 · ceiling 5/5 (25 Aug 2026)

Run: `bench/runner/run-bench.sh [--solver NAME] [--task ID] [--record]`
(no network, deterministic). Add tasks via `tools/gen_bench_corpus.py`.
Future agent solvers (bare vs skill-loaded) turn the skill's honesty
claim into a measured curve. If you improve a rule, add a trap for it.

## When unsure

Ask. If a number lacks a receipt, it does not exist. If a claim would
need an unverified source, report the gap instead of filling it. The
project's entire credibility rests on honest negatives committed openly.