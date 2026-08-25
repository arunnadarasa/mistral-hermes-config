# Best Practices: Mistral + Hermes

## Pre-Flight Checklist (Run Every Session)
- [ ] `MISTRAL_API_KEY` set in env (`echo $MISTRAL_API_KEY`)
- [ ] `discover_models: true` in `~/.hermes/config.yaml`
- [ ] Caches fresh (`ls -la ~/.hermes/*cache*.json` — today's date)
- [ ] Quick test: `hermes -m mistral-large-latest --provider mistral -z "ok"`

## Config Management
- **Never** edit `config.yaml` directly from agent tools.
- **Always** use `hermes config set <key> <value>` or `hermes config edit`.
- Keep provider config minimal — let discovery do the work.

## Model Selection
| Task | Model | Why |
|------|-------|-----|
| Evidence synthesis, debriefs | `mistral-large-latest` | Max reasoning, large context |
| Balanced default | `mistral-medium-latest` | Good speed/quality |
| Fast triage, KPI pulse | `mistral-small-latest` | Low latency, cheap |
| Code review (Guppy/HUGR/QIR) | `codestral-2508` | Code-specialized |
| MCP server debugging | `devstral-medium-latest` | Dev-tuned |
| Offline/edge | `ministral-8b-latest` | Small footprint |

## Verification Discipline
1. **Check the live API** (`curl /v1/models`) before trusting cache.
2. **Test inference end-to-end** — config can look right but fail at runtime.
3. **Log failures with root cause** — this repo is the failure memory.

## Security
- Key in `~/.env` only.
- Rotate if ever exposed.
- No keys in config, no keys in repo.

---

*Source: Verified live 2026-08-25 with Hermes default profile + Mistral provider.*
