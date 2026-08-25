---
name: lovable
description: Use when building/editing EndoTrack surfaces in Lovable (portal, whisperer, agent pages, demo copy) or when generated UI/copy references EndoTrack quantum results, NICE context, or certified numbers. Ingest docs/llms-full.txt as the project brain.
---

# Lovable — EndoTrack app-building workflow (super-detailed, 21 Aug 2026)

## NAME

`endo-track-build` — use this skill when building, editing, or reviewing
any EndoTrack surface in Lovable: the encrypted portal
(`arunnadarasa.github.io/nhscep2026`), the whisperer console, agent-facing
pages, or any UI/copy that references EndoTrack science, numbers, or the
quantum evidence. Also use when ingesting the project brain
(`docs/llms-full.txt`), onboarding teammates to Lovable, or when Lovable
generates anything that could touch the scientific claims.

## DESCRIPTION

Use when building or editing EndoTrack surfaces in Lovable (portal,
whisperer console, agent pages, demo copy), when ingesting
`docs/llms-full.txt` as the project brain, or whenever generated UI/copy
might reference EndoTrack quantum results, NICE context, or certified
numbers. Not for general-purpose app building unrelated to EndoTrack, and
not for writing new scientific analysis (that lives in the repo).
(The frontmatter description — what the catalog actually reads — is the
247-char compact version starting "Use when building/editing EndoTrack
surfaces in Lovable…".)

## INSTRUCTIONS

### 0. The project brain (ingest FIRST)

The single source of truth for ANY LLM tool (Lovable, GPTs, other agents):

```
docs/llms-full.txt   (repo root: arunnadarasa/nhsquantinuum — ~20 KB, self-contained)
```

- Paste the whole file into Lovable (project knowledge upload or chat) —
  no repo access needed. It contains: certified numbers, architecture,
  exact API contracts (MCP tools, bridge routes, x402 wire format, A2A
  card), portal mechanics, the 8 conventions, Nexus workflows, quantum
  design details, the payments ledger, dev commands, the judges' demo
  script, and team.
- If the file has changed since the last session, RE-ingest the new
  version before building. Stale context is the #1 source of wrong output.

### 1. Current scientific stance (22 Aug 2026 — keep Lovable honest)

This is the LOAD-BEARING section. EndoTrack's scientific state changed
materially today; any generated copy must reflect it:

| Topic | Certified state (say THIS) | Forbidden (never say) |
|---|---|---|
| Substrate (order-3 door) | n=56 negative committed (0.480 vs 0.585); **shot-scaling verdict SEALED (25 Aug): classically equivalent** — 128→512→2048→8192→32768 shots (5 levels, 7,700 pair-receipts) all flat, no shot budget recovers advantage; **real-kernel Selene-Gram gate REFUSE** (Δ −0.297, CI [−0.56, −0.03]) — classifier door closed 5 ways (Fourier wall / Quest 10q / real kernel / flight-deck shot-floor / shot-scaling seal) | "0.640 beats 0.513", "quantum beats classical at biomarker triage", any implication of a substrate advantage |
| External-credibility portfolio | **Six verified external passes** (docs/: ten-year-plan-relevance · governance-lessons (Marchant) · nhs-qrp-quantinuum-decks · nqcc-learnings · qhdc-paper-learnings · quantum-protein-papers-learnings) — all verbatim + page-cited + verified; institutional/vendor material NEVER EndoTrack evidence; plus TQI goldmine scan (docs/tqi-goldmine.md: Martellini anti-washing, Kop 'Hippocratic Quantum', QTAP NHS cohort, 4,915-paper review) · **5-journal scan portfolio committed** (docs/: nature-scan · x-scan · engj-scan · qsci-scan · aps-scan — ~95 Crossref/PubMed-verified findings, incl. Nützel parity post-selection on Quantinuum H1-1, QEC on H2-2 [[7,1,3]], Logical Accreditation (Kashefi), QCNNs classically simulable, Q-CHIPP 46q) · **genesis scan** (docs/genesis-scan.md: Nobel-2025 Clarke/Devoret/Martinis MQT+quantisation + Feynman 'imitate'≠'emulate' correction + Deutsch universality + Shor/Grover — 18/18 API-verified; Deutsch = why seven-engine cross-check is meaningful; Shor/Grover discipline with opposite sign = our honest-negative) · **PASQAL agentic-workflows finding** (docs/agentic-quantum-pasqal-relint-learnings.md: vendor-controlled proof of the verification gap — agent's plausible-but-wrong observable + hardware diagnosis caught only by domain-expert review; 43-exchange cost; their experiment_spec.json = our QAS envelope, convergent design) | Quoting vendor projections (2029/300-400%) or a lab's F1s as our receipts; citing any scan finding that wasn't API/Crossref/PubMed-verified; implying genesis papers are our hardware ancestry (trapped-ion, not superconducting) |
| Withdrawals | n=28 edge withdrawn; ablation Δ≈0.035 not decisive — reported by design. **Now STRUCTURAL via the evidence ledger** (`results/evidence_manifest.json` = sole authority current/superseded/archived; MCP resolves through `read_current_artifact("biomarker_auc")` → n=28 can never be served as current again) | Presenting the withdrawn claim as live |
| IP & credit (24 Aug, binding) | **The use case + clinical IP belong to Dr Natasha Waters FRANZCOG (clinical lead) — the team builds for HER use case in this hackathon.** Credit line for every surface: "clinical idea + use case IP: Dr Natasha Waters FRANZCOG (clinical lead); the team builds for her use case". User's own separate asset: "Clinical Quantum" UK trademark UK00004139363 (Class 41 education) — distinct from the clinical IP | Implying the team owns the clinical IP or the use case; conflating the trademark with Dr Natasha's clinical IP |
| Evidence ledger (current state) | **10 current kinds / 1 superseded** (biomarker_auc_n56 · referral_qubo_selene_v1 · pathway_reference_v1 · pathway_circuit_card_v1 · rotor_seven_engine_proof · iceberg_recovery_17q · flight_deck_falsification · g1_reduction_resolution · shot_scaling_verdict · simon_primitives_receipt; superseded: biomarker_auc_n28) — served by get_evidence_summary via the MCP/whisperer | Claiming any n=28-era state as current; inventing ledger entries |
| QAS receipt envelope | **Every committed result should carry qas/envelope/0.1** (receipt block: claims/engine/backend_qualifier/shots/seed/commit/envelope 4√(0.5/shots)/verdict); audit via tools/validate_receipts.py (PASS/GAP/STRUCTURAL/FAIL); 4 load-bearing receipts already migrated (flight-deck, rotor, Qulacs, Simon's) | Displaying result numbers without their envelope/engine qualifiers |
| SNOMED anchors | 9 verified SCTIDs in results/snomed_fixtures/endo_pathway_concepts.csv (129103003 Endometriosis · 724457006 Deep · 237116001 Endometrioma · 266599000 Dysmenorrhea · 76376003 Uterine endo · 237067000/279032003 pelvic pain · 17276009 Subfertility · 73632009 Laparoscopy) — vocabulary anchors only, NOT a SNOMED-compliance claim | Claiming SNOMED CT compliance or full RF2 integration |
| Mechanism arc (the ballast) | **Seven-engine RotorMap proof** (oracle 0.3643 = Selene 0.395 = H2-1LE 0.3867 = Helios-1E-lite 0.3447 = Aer 0.354 = H1-1LE 0.4160 = H1-Emulator 0.3379) · iceberg error detection (+0.030 @ 9q, +0.060 @ 17q) · N2/dimod QUBO (greedy fails, dimod hits optimum) · **KPI wall now mechanism_advantages 2/2 (documented pivot, pre-registered branch — not a hidden goalpost)** | Claiming a mechanism proof is a clinical outcome |
| Real-genome cohort | **Synthetic cohort built from REAL FinnGen R13 endometriosis summary stats: 3/9 Tier-1 PASS at n=240 (2⁸=256>240), 6/9 gate-paced REFUSE at n=400/600; realized h² 0.11–0.13** — certifies real marginals + declared interaction model, NOT "real disease structure". **Flight-deck probe: the SWAP-test Gram on this cohort is shot-floor-bound (k=0.0547 at first pair)** — the classifier question is closed four ways; the powered Gram's collapse is the measured, receipted outcome, not a "we haven't tried" gap | "The disease's own genetics encode quantum-exploitable structure", "real patient data", "the Gram hasn't been tried at proper power" |
| SelenePlus | **Access VERIFIED (job 0a1bf64f): MPS simulator + HeliosRuntime + QSystemErrorModel accepted** — emulator capability, NOT a QPU run. 17q plain circuits run on MPS; readout pattern fixed (result('c', measure_array)) | "Ran on Helios QPU" |
| QulacsBackend | **VERIFIED (job 807baa81: 14q GHZ correct physics)** — fast CPU statevector via pytket; the engine for the powered real-genome Gram (finale asset) | "Qulacs ran on a QPU" — it's an emulator |
| Hardware | Emulators + receipts (H2-1LE, Helios-1E-lite, H2/H1-Emulator, SelenePlus MPS); QPU = pre-registered post-shortlist. **SelenePlus scope (honest negative): 17q PLAIN circuits run; 17q + Toffoli-CSWAP depth hits the server size limit ('Unexpected end of stream' ×3 structures) — the +0.060 iceberg recovery is receipted on H2-Emulator, SelenePlus re-cert assessed-blocked** | "Ran on H2/Helios QPU" (QPU execution NOT done); implying the 17q iceberg re-certified on SelenePlus |
| Clinical | Research prototype on synthetic/public-aggregate data; NICE 2026 draft is context, not endorsement | "NICE approves EndoTrack/quantum", "diagnoses patients" |
| NICE framing | NICE funds Endotest + EndoSure for a 3-year evidence-generation window; **no registry exists** for the required data — that gap is the product | "NICE endorses us"; treat the draft guidance as final |
| Agent stack | MCP server **15 tools** (9 evidence + circuit_structure + execute_circuit + qdocs_search/get/index/llmsfull over a 328-page crawled Quantinuum docs corpus, llms-full.txt committed) · A2A card live · 7 real x402 payments (3 tokens) · **lambeq: the clinician's question rendered as a diagram/circuit** (`docs/assets/circuits/lambeq_question.png` — an ENCODING demo, never an analysis; deterministic router stays the answer source) | A tool count that doesn't match the repo; implying the lambeq diagram is evidence or analysis |
| Submission package | **KPI wall: mechanism 2/2 ✅ · submission drafts 5/5 ✅ · fresh_clone_reproducible ✅** (narrative v3 + tech report + four packs + beat-sheet) · verified_cells 51/500 climbing (pure aggregation, every cell provenance-noted) · tket sweep: every certified circuit ships its optimised twin (rotor 48→42, iceberg 72→64, observable-level equivalence) · **QTDA DQC1-hardness (25 Aug): C6 vs 2C3 WL-indistinguishable graphs DISTINGUISHED by quantum propagator trace — 4/4 backends confirmed (Selene/Quest ΔRe=0.2101, H1-1LE ΔRe=0.2286, H2-1LE ΔRe=0.2081, Helios-1E-lite ΔRe=0.2418); classical control row (1-WL hash + GNN aggregation + Betti) ALL FAIL; +2.5 score (scientific 13→15)** | Pretending the classifier question is open (closed **5 ways** — Fourier wall / Quest 10q / real-kernel REFUSE / flight-deck shot-floor / shot-scaling seal) |

### 2. The 8 conventions (non-negotiable for every Lovable build)

1. **Framing**: endometriosis only. Zero cancer/BCAC/CRUK/BCDB mentions —
   search generated text for these before accepting.
2. **Numbers**: only numbers from `docs/llms-full.txt` / `results/` —
   never invent AUC/fidelity figures. Every number in the repo carries
   shots+seed; if a number lacks a receipt, it does not go in the UI.
3. **Mock/real toggles**: any demo/payment UI needs an explicit mock/real
   switch. No fake "live" status.
4. **Clickable receipts**: tx hashes link to testnet.arcscan.app (new
   tab); (mock) labels when no real reference exists.
5. **No secrets in the page**: Alchemy RPC keys / payer private keys are
   env-only, never in Lovable-generated code or the portal.
6. **Static-only on the portal**: GitHub Pages has no server-side auth —
   the AES-GCM client-side gate is the security model. Plaintext content
   must never be committed to the publish dir (documented incident).
7. **Verification honesty**: if showing the trust story, use the three
   layers — L1 receipts (live), L2 arbiters incl. per-batch Bell control
   (live), L3 cryptographic verification (pre-registered QPU target, NOT
   claimed today). Never "cryptographically verified".
8. **A2A/MCP contracts**: `agent.json` (3 skills), MCP tools (**9 stdio**:
   7 evidence + `circuit_structure` (certified-circuit structural audits —
   the pictorial-mathematics view) + `execute_circuit` (agent-driven
   execution spec, no credentials)), bridge (7 intents, POST JSON, `mode`
   field, `force_mock` override) — generated JS must not break these
   contracts.
9. **Circuit orthography**: if surface copy cites certified circuits,
   reference the fixed grid rendering (gate-class→color; rotor13q ancilla
   idle band [28–64] = DD point, iceberg17q parity cadence) and the
   `circuit_structure` tool — never invent circuit statistics.

### 3. The playbook — what to do in each task type

**A. Portal build/refactor**
1. Regenerate with `python3 tools/gen_site.py` (repo side) then verify:
   `node tools/verify_portal.js <index.html>`.
2. A correct passphrase must unlock; a WRONG one must be rejected.
3. Keep the client-side AES-GCM gate; never add server-side auth
   assumptions (GitHub Pages has none).
4. Keep the hero/headline on the NICE-evidence-window framing ("the
   auditable evidence layer for NICE's 3-year endometriosis-test window"),
   NOT "Quantum Biomarker Triage".

**B. Whisperer console**
1. `public/whisperer.html` must keep the toggle markers and bridge
   contract: 7 intents, POST JSON, `mode` field.
2. The centerpiece demo beat: ask "what's the certified AUC?" → the
   console answers the n=56 NEGATIVE (0.480 vs 0.585, claim withdrawn),
   NOT the old 0.64. An agent that cannot serve a withdrawn claim is the
   product thesis.
3. Mock/real toggle + clickable Arcscan receipts (conventions 3–4).

**C. Demo/slide copy**
1. Follow the 3-minute arc: payer-documented gap → honest evidence agent
   centerpiece → A2A → noise/mitigation → agents pay → the window.
2. Use verified numbers only (convention 2). The five-engine F table, the
   iceberg recoveries, the dimod table — all in `llms-full.txt`.
3. Never smooth a negative; the withdrawal IS the scientific-integrity
   credential.

**D. Science-adjacent copy (model cards, claims)**
1. Match the repo's model card structure (Everitt & Ji 2024 framing),
   with the verification & trust section (three layers).
2. Cite the Born-Ultimatum guardrail (arXiv:2511.01845): before any
   advantage claim, the dequantization check runs and is reported.
3. If unsure whether a claim is certified, check via the `verify_artifact`
   pattern (repo `tools/endo_mcp_server.py`) or defer to `results/*.json`.

### 4. Output format

For any build, end with a compact checklist:

```
✅ Framing (endometriosis-only, no cancer terms scanned)
✅ Numbers (every figure traced to llms-full.txt / results/*.json)
✅ Toggles (mock/real where relevant)
✅ Receipts (tx links → arcscan, (mock) labels where needed)
✅ Secrets (none in generated code/pages)
✅ Static gate (AES-GCM portal, no plaintext in publish dir)
✅ Science honesty (withdrawal + shot-scaling verdict respected)
✅ Contracts (MCP/bridge/A2A intact)
```

If any item fails, list it in priority order — do NOT claim done.

### 5. Edge cases and how to handle them

- **Lovable lacks context** → point it at GitHub
  `arunnadarasa/nhsquantinuum` (docs/ has the same content in markdown);
  re-ingest `llms-full.txt` before continuing.
- **"An internal error occurred" toast** (2–4× on same request) → likely a
  task-transaction ROLLBACK, not a crash: dev server still alive, `git
  status` clean at last stable revision, no new files on disk, reflog
  churn. Do NOT debug app code — shift to a gated workflow (smaller
  turns, commit between steps). See the quantinuum skill's
  `references/lovable-orchestration.md` for the 30-second diagnosis
  checklist.
- **Stale science in context** → re-ingest the brain; verify the
  shot-scaling verdict + withdrawal language survived.
- **A requested figure isn't in the brain** → do not invent it; state it
  is not in the certified set and ask for the repo path.

### 6. Bundled files (this skill's package)

The repo ships this as a folder that can be zipped/uploaded (Lovable
imports `SKILL.md` at root or inside one wrapping folder):

- `SKILL.md` — this playbook.
- `references/scientific-stance.md` — the certified-numbers + forbidden-
  language tables (kept separate so the main file stays focused).
- `references/verification-layers.md` — the three-layer trust design
  (L1/L2 live, L3 pre-registered) with the guardrails.
- `references/api-contracts.md` — MCP tool list, bridge intents, A2A
  card, x402 wire format (mirrors llms-full.txt §API for quick lookup).

### 7. Best-practice compliance (per docs.lovable.dev/features/skills)

- Trigger-led description ✅ (see DESCRIPTION).
- One job per skill ✅ (build EndoTrack surfaces; science analysis stays
  in the repo).
- Boundaries + avoid ✅ (the Forbidden column above).
- Always-on rules → workspace knowledge, not this skill (conventions that
  apply to EVERY message belong in project knowledge; this skill fires on
  task type).
- Short playbook style ✅ (sections, bullets, direct instructions).
- Concrete values ✅ (real numbers above).
- Review & prune ✅ (this revision is the 21 Aug 2026 refresh: retirement
  of the ~18 KB note, new scientific stance, official anatomy per
  docs.lovable.dev/features/skills).