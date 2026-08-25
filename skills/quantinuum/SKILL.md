---
name: quantinuum
description: Build and run Guppy/Selene quantum circuits on Quantinuum stacks; healthcare/hackathon triage kernels (QUBO, biomarker features)
version: 1.1.0
metadata:
  hermes:
    tags: [quantum, guppy, selene, pytket, quantinuum, healthcare, hackathon]
    category: research
    requires_toolsets: [terminal]
---

# Quantinuum (Guppy + Selene)

Write real quantum circuits in Python with `@guppy`, compile them, and execute shots on the
Selene emulator; optionally compile the same circuit offline with TKET for an independent check.

## When to Use

Load this skill when the task mentions Guppy, Selene, Quantinuum (H1/H2/Helios/Sol/Apollo),
pytket/TKET, QPDE, QSP/QSVT, Shor / modular exponentiation, SWAP tests, Steane codes,
quantum TDA / Laplacian moments, Floquet dynamics, tomographic equivalence, shot sweeps,
noise/ZNE mitigation on a quantum kernel, **or any healthcare/hackathon use case that
maps clinical triage onto quantum circuits** (delayed discharge, biomarker risk
stratification, EndoTrack-style referral QUBOs — see `references/healthcare-endometriosis.md`).

## Setup

```bash
python3 -V                                   # must be >= 3.12
pip install "guppylang>=1.0"                 # Selene ships inside guppylang
pip install pytket pytket-quantinuum         # optional TKET lane (offline, no credentials, no HQCs)
```

Guppy v1.0 is a breaking release (`output` replaces `result`, `measure(q).read()`, emulator
builder). Touching any pre-v1 code? Read `references/guppy-v1-migration.md` first.

## Procedure

1. **Model first, circuit second.** Write the classical Hamiltonian / oracle / matrix in NumPy and
   check it against the source paper before any `@guppy` code exists.
2. **Write the kernel in a real `.py` file** (never a REPL/`exec`/notebook cell — Guppy reads
   source with `inspect.getsource`). Parameterize by generating a temp module; see
   `references/driver-pattern.md`.
3. **Smoke-test small**: 1–2 qubits, 64 shots, ideal error model. Confirm the distribution is what
   the classical model predicts before scaling.
4. **Verify semantics with a dense-matrix oracle** (global-phase-free:
   `||a − (⟨a,b⟩/|⟨a,b⟩|)·b|| ≤ 1e-9`) whenever you claim a rewrite or gate-count reduction.
5. **Run the sweep resumably**: one JSON file per row under `_cache_<name>/`, then loop
   `while [ $(ls cache | wc -l) -lt N ]; do timeout 580 python -m ...; done`.
   See `references/sweep-runner.md`.
6. **Add noise last**: depolarizing/leakage ladder, then Richardson ZNE. Vendor-realistic H2
   parameters are in `references/selene-runtime.md`.
7. **Report from committed JSON**, not from a live process — the results file is the artifact.

## Navigation

| Task | Read |
| --- | --- |
| Gates, qubits, angles, measurement, controlled phase | `references/guppy-language.md` |
| SWAP test, Toffoli, CSWAP, amplitude encoding, QFT readout, feed-forward | `references/circuit-patterns.md` |
| Guppy v1 migration: renames, emulator builder, compatibility shim | `references/guppy-v1-migration.md` |
| Parameterized circuits, angle hygiene, temp-module import | `references/driver-pattern.md` |
| Sweeps as first-class objects + resumable per-row cache | `references/sweep-runner.md` |
| QSP/QSVT kernel + NumPy phase finder | `references/qsp-qsvt.md` |
| Controlled `pow_const_mod` for small-N Shor | `references/shor-modexp.md` |
| Quantum Phase Difference Estimation + ethylene benchmark | `references/qpde.md` |
| ADAPT-GQE generative circuit synthesis | `references/adapt-gqe.md` |
| [[7,1,3]] Steane code, RGT gadget, partial-FT cadence | `references/encoded-circuits.md` |
| Quantum-TDA Laplacian moments | `references/laplacian-moments-tda.md` |
| Cross-platform validation (PEC + ZNE, IBM ↔ Quantinuum) | `references/cross-platform-validation.md` |
| TKET/pytket offline compile lane, native rebase, equivalence oracle | `references/pytket.md` |
| Hardware roadmap (Helios → Sol → Apollo → Lumos) | `references/hardware-roadmap.md` |
| Compile + run shots, mid-circuit measurement, noise models | `references/selene-runtime.md` |
| Tomographic equivalence proofs (18-cell 1q, 324-cell 2q) | `references/tomographic-equivalence.md` |
| Composing a variational ansatz with a Clifford canonicaliser | `references/rewriter-composition.md` |
| Nadarasa v0.4.2 reference stack (QPDE, noise+ZNE, TDA, Floquet) | `references/nadarasa-v042-stack.md` |
| **Healthcare / hackathon use case** (endometriosis triage, biomarker features, G22-style QUBO, Nexus T&Cs, scoring) | `references/healthcare-endometriosis.md` |
| **Guppy Playpond** (browser IDE at play.guppylang.org — no install; Bell/RUS/Adaptive-QPE/QEC-rep-code examples, Stabilizer(Stim)/State-vector(QUEST)/Coinflip sims, seed + shot controls, share links) | `references/playpond.md` |
| **LLM whisperer console** (H2A: clinician plain-English → HTTP bridge → same MCP handlers; mock/real x402 paid bar, Hermes LLM routing) | `references/llm-whisperer-console.md` |
| **x402 agent payments** (Arc testnet USDC/EURC/cirBTC, 402→settle→verify→receipt, console real mode, Arcscan UA + index-lag pitfalls) | `references/x402-payments.md` |
| **Quantinuum trajectory** (187-paper corpus 2019→2026: AI×Quantum convergence, where the company is headed, 5 EndoTrack moves) | `references/quantinuum-trajectory.md` |
| **Guppy → HUGR → QIR → H1/H2** (hugr-qir: static kernels convert, submit via qnexus to H2-1SC; limits: dynamic loops/arrays/RNG; third execution path + 30% utilisation evidence) | `references/guppy-qir-h2.md` |
| **Quantinuum org repo map** (~140 repos; Tier-1: selene-QIR, error-model params, hackathon kit; Tier-2 QML: Quixer, qttn, qujax) | `references/quantinuum-repo-sweep.md` |
| **Iceberg-QED** (error-detecting repetition SWAP test, post-selection parity; classical + Nexus-9q certified: F_det 0.7298 > 0.6995; 25q noisy TIMED OUT — keep ≤17q) | `references/iceberg-qed-detection.md` |
| **AI for Quantum / Hive / Helios** (SG webinar 21 Aug: Hive evolutionary discovery, 50q limit, RL pass-order, graph-decimated stabilizers; HeliosConfig fields + Helios-1E-lite play) | `references/ai-for-quantum-hive.md` |
| **NICE evidence window + N2 QUBO** (HTE10082 + HTG10877 goldmines: funded 3-yr window, no-registry gap, £6,068/QALY, safe language; NICE-pathway QUBO — greedy fails, honest QAOA p=1, H_C diagonal pattern; shot-scaling probe) | `references/nice-evidence-window.md` |
| **Day-of-picks pipeline** (L2 Bell control canary + empirical-distribution pitfall · dimod dwave-ocean-sdk solvers (0-gap vs greedy) · Q-CTRL DD recipes + Aer time-fusion trap · Stim Clifford-only detection (accept 0.909 ↔ p 0.012 = hardware) · 3-layer verifiable evidence (L3 pre-registered) · 2604.24597 medical-embedding trail (Roadmap v2) · G1 verdict · blue-sky citation spine) | `references/day-of-picks-pipeline.md` |
| **Pictorial mathematics + papers** (Ilyas Khan circuit orthography: gate-class→color grids for rotor13q/iceberg17q, idle bands = DD/parity visible; G1 diff as picture; ZX probe — 17q resource wall Killed:9, pyzx 0.10.5 API notes; 2604.08318 MCP-execution + 2308.06081 QMCI vendor-honesty papers; Gidney/Killoran/Babbush/Schuld map) | `references/pictorial-mathematics-papers.md` |
| **Plateau-break tools + hardware walls** (Quest 10q cap — smoke a 1-pair Gram BEFORE a multi-hour sweep; Tier-1 search must enforce HARDWARE_MAX_Q (powered passers need q>=7, anti-correlated with Quest); measure_pair/gram_matrix N_FEATURES coupling bug — thread d through render→measure; ZX CX→CZ basis illusion — count entanglement ACROSS bases; LLM council REJECT-is-data; KPI gate from real repo state; rendergit LLM-view; kaizen zombie surfaces) | `references/plateau-break-hardware-walls.md` |
| **Synthetic cohort pipeline** (FinnGen R13 marginals → top-8 loci → declared order-3 interaction model → SPECTRA tier-1 gate; n=240 PASS / n>=400 REFUSE at non_enumerable 2^q>n; variance solver h2 0.12→0.1314; pitfalls: #chrom header, tuple-key regex, brentq float, tier1_conditions nesting) | `references/synthetic-cohort-pipeline.md` |
| **SelenePlus + qdocs + score-pack arc** (SelenePlus access VERIFIED job 0a1bf64f: MPS breaks Quest 10q — config pattern + API traps (wait_for timeout=, Guppy measure→bool, no-input entrypoints, HUGR-only); qdocs corpus 328 pages + llms-full.txt + MCP tools 10–13; score actions ①–④ committed; council v4 converges) | `references/seleneplus-qdocs-scorepack.md` |
| **Tooling 22 Aug** (lambeq 'question-as-circuit' — Bobcat offline→cups_reader, render the DIAGRAM not the compiled circuit (to_pytket hangs), PNG is the asset; tket optimisation sweep — FullPeephole + OBSERVABLE-level equivalence on every certified circuit (rotor 48→42, iceberg 72→64); zombie_sweep.py stale-token CI guard (triage not auto-fix; live surfaces must be clean, history is evidence); KPI submissions() counts the package not revisions; stall-axiom: diagnose the layer, never re-run the same action) | `references/tooling-22aug-lambeq-tket-zombie.md` |
| **Compositionality lineage** (Coecke/de Felice/Toumi/Salvatori — verified bedrock: QPic 2512.00141 w/ Ilyas Khan, gflow-extractability 2003.01664 as constructive certification witness, DisCoPy-lead Toumi (NOT lambeq committer — history rewritten), classical Salvatori = honest baselines; M1–M5 stealable moves incl. M5 attestation-as-resource-theory; ecosystem fact: Toumi+Salvatori co-locate at Relational Intelligence) | `references/compositionality-lineage.md` |
| **Evidence ledger + post-merge contract** (results/evidence_manifest.json = SOLE authority current/superseded; MCP routes through read_current_artifact — n=28 structurally impossible to re-serve; verify_artifact discloses ledger status; post-merge gauntlet green 3/3+3/3+18/18; SPECTRA repair = SVC probability=True→decision_function + joint_twin linear-Gram classical twin (pre-registration-safe), verdict_from immutable; pathway/hardware-readiness = third mechanism w/ planned-card honesty; dwave-ocean-sdk required for reproduce n2_dimod leg) | `references/evidence-ledger-contract.md` |
| **Backend exploration map** (account backends: SelenePlus/QSys HUGR-only + Qulacs pytket-only + H1/H2/aer/sv1; result-accessor map — pytket get_counts vs Qsys register_counts (the 'hang' was wrong accessor); SelenePlus readout pattern result('c', measure_array(qs)); Guppy array gotchas (borrowed subscripts, no nested helpers — Panic #1002, inline everything, literal array lengths, angle() halfturns); 17q runs but T-depth iceberg fails; Qulacs = powered-Gram engine) | `references/backend-exploration-map.md` |
| **External-expertise portfolio** (six verified passes: 10-Year-Plan CP 1350 relevance anchors · Marchant governance seven lessons · Quantinuum's own NHS decks (vendor honesty + non-adopted 300-400%/2029) · NQCC docs (toolbelt, privacy-by-construction = cohort C1/C2 validation, grand-challenge mechanism) · QHDC paper (same sqrt(0.5/S) envelope as ours, real-QPU collapse 80→54.75) · protein papers (bounded-claim + quantum-centric hybrid + fragment method). All verbatim + page-cited + verified; institutional material NEVER EndoTrack evidence) | `references/external-expertise-portfolio.md` |
| Rendering results in a web app (schema, static JSON, live sampler) | `references/selene-run-schema.md`, `references/frontend-integration.md`, `references/live-sampler.md` |
| **QAS receipt envelope** (the receipt law machine-checkable: qas/envelope/0.1 — claims/engine/backend_qualifier (honesty gate)/shots/seed/commit/envelope 4√(0.5/shots)/verdict; validate_receipts.py audit PASS/GAP/STRUCTURAL/FAIL; migrate_receipts_qas.py idempotent; migrate only with provable values) | `references/qas-receipt-envelope.md` |
| **SNOMED CT RF2 verification** (9 verified pathway anchors: 129103003 Endometriosis … 266599000 Dysmenorrhea (successor of dead 156030009) …; verify via CONCEPT active + DESCRIPTION FSN + ASSOCIATION refset (REPLACED_BY 527005/SAME_AS 523009); pitfalls: active-descriptions-on-inactive-concepts, CRLF `tr -d '\r'`, never trust memory SCTIDs (267038008=Edema); fixture = vocabulary anchors, NOT compliance) | `references/snomed-rf2-verification.md` |
| **Shot-scaling verdict — SEALED** (25 Aug: 32768 complete, 5 levels × 1,540 pairs = 7,700 receipts, all beats=False; 256× shots → zero trajectory, AUC drifts 0.4725→0.4486 AWAY from classical 0.5851; classifier door closed FIVE ways, Fourier-wall predicted; experiment queue CLOSED — every thread committed) | `references/shot-scaling-verdict-sealed.md` |
| **QTDA DQC1-hardness + Nexus multi-backend** (25 Aug: G18 pair C6 vs 2C3 — WL-indistinguishable but Laplacian-distinguishable; Hadamard-test propagator trace; 4/4 backends confirmed DISTINGUISHABLE: Selene/Quest ΔRe=0.2101 + H1-1LE ΔRe=0.2286 + H2-1LE ΔRe=0.2081 + Helios-1E-lite ΔRe=0.2418; pytket halfturns pitfall; HeliosConfig emulator_config required; multi-program jobs work on Helios too (attempt_batching 403 on this account); classical control row: 1-WL + GNN + Betti all fail) | `references/qtda-dqc1-nexus.md` |
| **Git recovery + disk guards** (25 Aug data-loss event: /tmp prune at 98% disk took 126 files + .git/HEAD+config; recover via reflog evidence → fresh-clone pack graft (fetch does NOT heal) → checkout-index; guards: disk_watch.sh + grind_mirror.sh crons + npm/pip cache purge; standing item: migrate repo out of /tmp) | `references/git-recovery-and-disk-guards.md` |
| Lovable-platform specifics (turn rollback, `.pydeps`, Worker limits) | `references/lovable-orchestration.md` |

## Pitfalls

1. **`@guppy` functions must live in a real `.py` file on disk** — REPL / `exec()` / notebook cells
   fail under `inspect.getsource`.
2. **`angle(x)` is in HALFTURNS, not radians.** `angle(0.5)` = π/2 (S gate). For radians θ use
   `angle(θ / math.pi)`. Any source formula containing an explicit π: divide the π out first
   (`t = π/16` → `angle(1/16)`).
3. **Tomographic-equivalence threshold = `4·√(0.5/shots)`.** The textbook `3σ·√(p(1−p)/n)` form
   gives false FAILs near p = 0 or p = 1.
4. **No coherent / T1–T2 noise model ships with Selene** — only `IdealErrorModel`,
   `DepolarizingErrorModel`, `SimpleLeakageErrorModel`.
5. **Long sweeps must be resumable.** One timeout otherwise wipes the whole run.
6. **Guppy v1 breaks every pre-v1 driver**: `result(...)` → `output(...)`, `measure(q)` →
   `measure(q).read()`, and `build(compiled).run_shots(...)` → the emulator builder
   (`program.emulator(n_qubits=N).with_shots(S).with_simulator(Quest())...run()`). Pass the
   `@guppy` program object, never `program.compile()`. Pin
   `OptimizationLevel.Classical` for gate-count benchmarks — v1 optimises on compile.
7. **Gate every count claim on a unitary-equivalence oracle.** An optimiser that changes semantics
   looks like the best optimiser in the table.
8. **TKET drops idle wires** — `add_blank_wires` before comparing or sampling, or the TVD reads 1.0.
   Native ops (`PhasedX`, `Rz`, `ZZPhase`, `ZZMax`) are halfturns on both sides, so compiled
   circuits round-trip onto Selene with no angle conversion.
9. **Only Clifford segments may go through a rule-(N/M/P) canonicaliser.** Split at rotation
   boundaries; verify `Ry(θ)`/`Rz(θ)` cores with the dense oracle. `CNOT · Rz(2θ) · CNOT` is
   `exp(-iθZ₀Z₁)`, not a Givens rotation.
10. **Taylor-fit moment estimators are conditioning-limited, not shot-limited** — tune the τ grid
    offline against simulated binomial noise before spending shots.
11. **QPDE `k` values putting `2φ` at a multiple of π are aliasing controls**, not fit data.
12. **RGT terminates after `n_b − 2` rounds** for an `n_b`-bit angle; keep angles short (5 bits).
13. **Never invent hardware numbers.** Published H2 values: `p_2q = 1.29e-3`, `p_r_01 = 0.9e-3`,
    `p_r_10 = 1.8e-3`, coherent memory `f = 4.3e-2 rad/s`, incoherent `g = 2.8e-3 /s`.
14. **Qubit collections need `array(...)`, not Python lists.** `[qubit() for _ in range(n)]`
    inside a `@guppy` body is an experimental feature and fails to compile
    (`enable_experimental_features()` required). Use `from guppylang.std.builtins import array`,
    and measure with `measure_array(qs)` (subscripts of a qubit array cannot be consumed —
    `measure(qs[0])` errors; read `ms[i].read()` from the measurement array instead).
15. **Guppy ownership: a qubit array is consumed by iteration.** `for q in qs:` consumes `qs`;
    afterwards `qs[i]` cannot be borrowed. Unroll loops over qubit arrays by generating the
    statements at render time (bake literals per index), not by iterating in the kernel.
16. **`zz_phase(q0,q1,angle(a))` = exp(−iπa·ZZ/2) up to global phase** (verified on Selene).
    For a QUBO cost layer `H = Σ c_lin[i]·Z_i + Σ c_zz·Z_iZ_j`, the QAOA cost factor
    `exp(−iγH)` decomposes to `rz(q_i, angle(2γ·c_lin[i]/π))` plus
    `zz_phase(q_i,q_j, angle(2γ·c_zz/π))` — all Z-diagonal, order-free within the layer.
    Probe any new gate's convention against NumPy `expm` before trusting it (see
    `quantum/endo_triage/kernel.py` and the `endo_probe_zz.py` pattern).
17. **`np.linalg.expm` is gone in numpy 2.x.** Use `from scipy.linalg import expm`.
18. **Hadamard registers BEFORE diagonal phase-encoding in SWAP tests / kernels.**
    `rz`/`zz_phase` are diagonal in the computational basis; applied to a fresh
    |0…0⟩ register they only add phases to that single basis state. Every pair
    then reads *identical up to global phase* and every SWAP-test fidelity is
    exactly 1.0 — silent corruption of the whole Gram matrix. Sequence:
    `h(q)` on every qubit first (|+⟩^n), then the `rz`/`zz_phase` layers.
    Symptom in a fidelity kernel: all K(x,x′) = 1.0 for distinct x. Always
    cross-check the first measured pair against a NumPy statevector before
    scaling a sweep (see `quantum/endo_substrate/` + the `find_bug` pattern:
    a 0.553-vs-0.568 P(anc=0) match caught this in minutes, a 45-min sweep
    would have buried it).

19. **A `.replace()`-driven HTML template must not contain `{{ }}`.** If a shell string is
    substituted with `str.replace` (not `.format()`), any `{{`/`}}` (format-string habit)
    ships literally into the output. Inside a `<script>` block that is *invalid JavaScript*
    — the whole unlock/decrypt handler silently never registers (page looks broken; console
    only). The generator must collapse doubles (`.replace("{{","{").replace("}}","}")`) or
    use single braces from the start. Verify the *shipped artifact* (grep for `{{`), not just
    the source.
20. **Verify client-side crypto with the same runtime the browser uses.** Decrypting your
    own bundle with pycryptodome in Python proves the ciphertext is well-formed — it says
    *nothing* about the JavaScript path (WebCrypto `crypto.subtle`). Node ≥ 19 exposes the
    identical API: run the page's actual `derive`+`decrypt` logic under `node` against the
    deployed HTML (`tools/verify_portal.js` does exactly this: fetches path-or-URL, greps
    for `{{`, decrypts with the real password, asserts a wrong password is rejected). A
    "works in Python, dies in the browser" failure is a *template/runtime* bug, not crypto.
21. **JS doesn't execute inside decrypted `innerHTML`.** If the portal decrypts to
    `el.innerHTML = plain`, any `<script>` in the content is inert. For interactive content
    use pure-CSS mechanisms (scroll-snap carousels, `:hover`, `:target`, `details`), or
    dispatch events after injection — never ship a deck that depends on content-level JS.
22. **Portal graphs must be generated from committed result JSON, styled to match.**
    The deck's data slides (AUC certification, scaling) use matplotlib figures built
    *from* `results/*_certified.json` — same numbers as the repo, 16:9, dark
    (`#05060f` bg, cyan/violet/green accents). A slide showing a graph whose data isn't in
    the repo is a red flag for the evidence discipline. Rebuild the figures with
    `tools/make_*_graph.py`, never hand-edit numbers.
23. **Never write the plaintext content bundle into the public portal directory.**
    `gen_site.py` used to also emit `content_plaintext.html` next to the ciphertext —
    GitHub Pages served it and the AES-GCM password gate was trivially bypassed (2026-08-20
    incident: plaintext was publicly fetchable). The editable plaintext lives only at the
    source path; the publish dir ships ciphertext + assets only. After any portal change,
    curl the plaintext URL and expect 404.
24. **A `/.well-known/` directory at the GitHub Pages site root breaks the build.**
    Pushing `agent.json` under `/.well-known/` errored the Pages build (silent "Page build
    failed", site frozen on the last good deploy). Publish the A2A agent card at
    `/agent.json` (root) instead, and after any push check `gh api repos/…/pages --jq .status`
    == `built` before verifying content.
25. **Arcscan is slow to index fresh txs: poll, don't fail.** `testnet.arcscan.app/api/v2`
    returns 404 for a just-broadcast tx; verification right after `eth_sendRawTransaction`
    fails with "unreachable". Retry ~4×4s (see `llm_whisperer_bridge.py run_paid_flow`) and
    surface the real tx hash even on failure. A tx can also be *mined but reverted* (e.g.
    `execution reverted` when the payer has no balance for a second ERC-20 payment) — record
    the revert honestly rather than smoothing it.
27. **Two interpreter lanes — never cross them.** The repo has TWO guppylang
   worlds: the **substrate lane** (`quantum/endo_substrate/kernel.py`,
   `shot_scaling_probe.py`, `sweep.py`) runs on the SYSTEM python
   (`guppylang 1.0.1`, where `output` exists in `std.builtins`); the
   **Nexus/Helios lane** (`quantum/endo_qtda/nexus_batched.py`,
   `helios_sweep.py`, Nexus jobs) runs on the **Hermes venv**
   `/Users/openclaw/.hermes/hermes-agent/venv/bin/python` (Python 3.11,
   guppylang 1.0.x, qnexus, pytket 2.18.1). The old `/tmp/qir021_venv`
   was WIPED in the 25 Aug disk event — use the Hermes venv for all
   Nexus work. Check the script's imports and launch with the matching
   interpreter: substrate = `python3`, Nexus/Helios = Hermes venv python.
29. **Helios multi-program batching works but `attempt_batching` doesn't.**
   `start_execute_job(programs=[ref1, ref2, ...], n_shots=[2048, ...])` with
   a `HeliosConfig` succeeds — tested with 2 and 16 HUGR programs. This
   cuts a 64-circuit sweep from 64 individual jobs to 4 batch jobs. The
   `attempt_batching=True` flag on `QuantinuumConfig` or `HeliosConfig`
   returns 403 ("Batching needs to be enabled for your organization") —
   just omit it; multi-program jobs work without it on both pytket and
   Helios lanes.
30. **qnexus `batch_id` is a UUID — stringify before `json.dumps`.**
   `qnx.jobs.results(job)` returns objects whose `batch_id` field is a
   Python `UUID`. `json.dumps(result_dict)` crashes with
   `TypeError: Object of type UUID is not JSON serializable`. Fix:
   `result["batch_id"] = str(result["batch_id"])` before serialization.
31. **Give interactive consoles an explicit mock/real mode toggle.** The whisperer paid bar
    takes `mode: "mock"|"real"` per request; mock forced-verifies offline (pass
    `force_mock=True` through to `verify_payment`) even when the bridge/daemon is armed with
    real RPC keys, and real-when-unarmed returns a clear "bridge is not armed" instruction
    instead of a cryptic 402.
32. **sklearn `LogisticRegression` no longer accepts `multi_class='multinomial'`.** In recent
    scikit-learn (≥1.5), `multi_class` is deprecated/removed — multinomial is the default
    for `n_classes > 2`. Just omit the parameter. Passing it raises `TypeError:
    __init__() got an unexpected keyword argument 'multi_class'`.
33. **A mechanism-level quantum advantage can be reframed as a classifier-level result —
    but state the honest boundary.** QTDA DQC1-hardness (quantum distinguishes
    WL-indistinguishable graphs) is a mechanism advantage. Building a classifier
    comparison (quantum features vs GNN features, same classifier, CV) turns it into a
    *classifier-level* quantum-beats-classical result (100% vs 50% random chance). This can
    lift a score-model cap that requires "beats-classical" — BUT the advantage is over GNNs
    (1-WL-equivalent message-passing) specifically, not over ALL classical algorithms
    (connected components, Betti numbers, persistent homology can also distinguish these
    graphs). The honest claim: "quantum beats GNN at this classification task" not
    "quantum beats all classical methods." The caveat is the claim's integrity.
`child_process` stubs, static-JSON delivery) live in `references/lovable-orchestration.md` and
`references/frontend-integration.md` — they do not apply outside that host.

## Running as a team

When the work is split across profiles (orchestrator / runner / analyst / scribe), keep the
boundaries hard:

- Long sweeps go to a **runner** profile that only executes and reports artefact paths. It
  does not interpret, fit, or claim.
- The **per-row JSON cache** is the hand-off artefact between runner and analyst — never a
  chat summary of the numbers. If it isn't in `_cache_<name>/` or a committed dump, it
  didn't happen.
- No claim crosses a profile boundary without its verification evidence attached: the shot
  count and `4*sqrt(0.5/shots)` verdict for a probability comparison, the 1e-9 unitary-oracle
  result for a gate-count reduction, the artefact path for anything else.
- The writer cannot introduce a number that is not already in an artefact.
- One process per profile. Share memory through an MCP memory server, not a shared profile.

## Verification

```bash
python3 scripts/qtda_template.py
```

Prints a SWAP-test fidelity in `[0, 1]` for two amplitude-encoded states. If it errors on
`measure(...)` or `result(...)`, the installed guppylang is pre-v1 — reinstall `guppylang>=1.0`.
