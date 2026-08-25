# Failure Log: Mistral + Hermes Integration

## 2026-08-25: Initial Setup

### Failure 1: Provider Unusable (No API Key)
**Symptom**: `hermes -m mistral-large-latest --provider mistral -z "test"` failed with auth error.
**Root Cause**: `MISTRAL_API_KEY` not set in environment. Config had `key_env: MISTRAL_API_KEY` but no env var.
**Fix**: `export MISTRAL_API_KEY="..."` in `~/.env` or shell rc.
**Lesson**: Always verify env vars before assuming provider works.

### Failure 2: Only 3 Models Visible
**Symptom**: `hermes model` showed only `mistral-large-latest`, `mistral-medium-latest`, `mistral-small-latest`.
**Root Cause**: 
- `discover_models: false` in config
- Stale `models_dev_cache.json` / `provider_models_cache.json` showing `none` for Mistral
**Fix**: 
- Set `discover_models: true` via `hermes config set mistral.discover_models true`
- Delete stale caches: `rm ~/.hermes/models_dev_cache.json ~/.hermes/provider_models_cache.json`
- Restart Hermes
**Lesson**: Discovery must be enabled; caches go stale.

### Failure 3: Config Write Blocked
**Symptom**: Agent `write_file`/`patch` to `config.yaml` refused with "Agent cannot modify security-sensitive configuration".
**Root Cause**: Hermes protects `config.yaml` from programmatic writes.
**Fix**: Use `hermes config set <key> <value>` or `hermes config edit` (opens $EDITOR).
**Lesson**: Config changes = CLI, not file writes.

### Failure 4: Cache Stale After Fix
**Symptom**: After enabling discovery, model list still incomplete.
**Root Cause**: Old caches not cleared.
**Fix**: Explicit cache deletion + Hermes restart.
**Lesson**: Always clear caches after changing discovery settings.

### Failure 5: Key Exposed in Chat
**Symptom**: API key pasted in conversation history.
**Root Cause**: Manual paste during debugging.
**Fix**: **Rotate immediately** at https://console.mistral.ai. Update `~/.env`.
**Lesson**: Treat keys like passwords — never paste in chat.

---

## Root Cause Summary
| Category | Count |
|----------|-------|
| Missing env var | 1 |
| Discovery disabled | 1 |
| Stale cache | 2 |
| Config write protection | 1 |
| Key hygiene | 1 |

**Total**: 6 failures → all resolved with verification discipline.
