# Mistral + Hermes Best Practices & Config

A curated repo for using Mistral LLM effectively with Hermes Agent — config, failures, scripts, and lessons learned.

## 🎯 Purpose
Document the setup, failures, and verified patterns for running Mistral models (large/medium/small + codestral/devstral/ministral) inside Hermes Agent. No project-specific data — purely Hermes/Mistral operational knowledge.

---

## ✅ Verified Working Config (Aug 25, 2026)

### Provider Registration
```yaml
# ~/.hermes/config.yaml
providers:
  mistral:
    api: https://api.mistral.ai/v1
    name: Mistral
    key_env: MISTRAL_API_KEY
    discover_models: true  # <-- critical: enables auto-discovery of all Mistral models
    models:
      - mistral-large-latest
      - mistral-medium-latest
      - mistral-small-latest
      - codestral-latest
      - devstral-medium-latest
      - devstral-latest
      - ministral-8b-latest
      - ministral-3b-latest
```

### Environment
```bash
# ~/.env or shell rc
export MISTRAL_API_KEY="your_key_here"  # never commit this
```

### Model Discovery
With `discover_models: true`, Hermes calls `GET https://api.mistral.ai/v1/models` and populates `models_dev_cache.json` / `provider_models_cache.json`. Verified live — returns 10+ models (large/medium/small, codestral, devstral, ministral, etc.).

---

## ❌ Failures Encountered

| Failure | Root Cause | Fix |
|---------|------------|-----|
| **Mistral provider unusable** | `MISTRAL_API_KEY` not set in env | Set `export MISTRAL_API_KEY=...` in `~/.env` or shell |
| **Only 3 models visible** | `discover_models: false` + stale caches | Set `discover_models: true`; delete stale caches |
| **Config write blocked** | Hermes protects `config.yaml` from agent writes | Use `hermes config set <key> <value>` or `hermes config edit` |
| **Cache stale** | `models_dev_cache.json` showed `none` for Mistral | Remove caches; Hermes regenerates on next start |
| **Key exposed in chat** | API key pasted in conversation | **Rotate immediately** at console.mistral.ai |

---

## 🔧 Scripts

### `verify_mistral_setup.py`
Quick health check: validates key, model list, and a test inference.

```python
#!/usr/bin/env python3
import os, subprocess, json, sys

def check_key():
    key = os.getenv('MISTRAL_API_KEY')
    if not key:
        print("❌ MISTRAL_API_KEY not set")
        return False
    print("✅ MISTRAL_API_KEY present")
    return True

def check_models():
    try:
        result = subprocess.run(
            ['curl', '-s', '-H', f'Authorization: Bearer {os.getenv("MISTRAL_API_KEY")}',
             'https://api.mistral.ai/v1/models'],
            capture_output=True, text=True, timeout=15
        )
        data = json.loads(result.stdout)
        models = [m['id'] for m in data.get('data', [])]
        print(f"✅ Mistral API returned {len(models)} models")
        for m in models[:5]:
            print(f"  - {m}")
        return True
    except Exception as e:
        print(f"❌ Model fetch failed: {e}")
        return False

def test_inference():
    try:
        # Quick oneshot test
        result = subprocess.run(
            ['hermes', '-m', 'mistral-large-latest', '--provider', 'mistral',
             '-z', 'Say "Mistral is ready" in one sentence.'],
            capture_output=True, text=True, timeout=60
        )
        if result.returncode == 0:
            print(f"✅ Inference test passed: {result.stdout.strip()[:80]}")
            return True
        else:
            print(f"❌ Inference failed: {result.stderr[:200]}")
            return False
    except Exception as e:
        print(f"❌ Inference test error: {e}")
        return False

if __name__ == '__main__':
    ok = all([check_key(), check_models(), test_inference()])
    sys.exit(0 if ok else 1)
```

### `refresh_mistral_cache.py`
Clears stale caches so Hermes re-discovers Mistral models on next launch.

```python
#!/usr/bin/env python3
import os, shutil
from pathlib import Path

HERMES_HOME = Path.home() / '.hermes'
CACHES = [
    HERMES_HOME / 'models_dev_cache.json',
    HERMES_HOME / 'provider_models_cache.json',
]

for c in CACHES:
    if c.exists():
        c.unlink()
        print(f"Removed stale cache: {c}")
    else:
        print(f"Already clean: {c}")

print("Done. Restart Hermes to trigger fresh model discovery.")
```

---

## 📋 Best Practices (Verified)

### 1. Always Verify Before Trust
- **Never trust cached model lists** — run `hermes config` or the verification script.
- **Check the live API** (`/v1/models`) before assuming models are available.

### 2. Use `discover_models: true`
- Lets Hermes auto-populate the full Mistral catalog.
- Avoids manual maintenance of the `models:` list.

### 3. Keep Keys Out of Config
- Use `key_env: MISTRAL_API_KEY` + `~/.env`.
- Never write keys to `config.yaml` or commit them.

### 4. Test Inference End-to-End
- A config that "looks right" may still fail at inference (wrong base_url, expired key, rate limit).
- Run a quick oneshot: `hermes -m mistral-large-latest --provider mistral -z "test"`

### 5. Rotate Keys If Exposed
- If a key appears in logs/chat/history → revoke at console.mistral.ai immediately.

### 6. Use the Right Model for the Task
| Model | Best For |
|-------|----------|
| `mistral-large-latest` | Complex reasoning, evidence synthesis, debriefs |
| `mistral-medium-latest` | Balanced speed/quality; good default |
| `mistral-small-latest` | Fast triage, surface checks, KPI pulse |
| `codestral-2508` | Code review, quantum circuit (Guppy/HUGR/QIR) |
| `devstral-*` | Debugging, MCP server code |
| `ministral-*` | Edge/offline scenarios |

---

## 🔄 What We'd Do Differently Next Time

1. **Set the API key FIRST** — before any config edits.
2. **Enable `discover_models: true` immediately** — not after discovering missing models.
3. **Run the verification script on every new session** — catches stale caches/key issues early.
4. **Document the exact Hermes CLI commands** for config (not file edits).
5. **Use `hermes config set` / `hermes config edit`** — avoids the "agent cannot modify config" block.
6. **Separate provider config from project config** — this repo is purely Hermes+Mistral.

---

## 📄 Files in This Repo

| File | Purpose |
|------|---------|
| `README.md` | This document |
| `config.yaml.example` | Example Hermes Mistral provider config |
| `verify_mistral_setup.py` | Health check script |
| `refresh_mistral_cache.py` | Cache clearing script |
| `failures.md` | Detailed failure log with root causes |
| `best-practices.md` | Condensed best-practice checklist |

---

## 📦 Usage

```bash
# Clone
git clone https://github.com/arunnadarasa/mistral-hermes-config.git
cd mistral-hermes-config

# Run health check (requires MISTRAL_API_KEY in env)
export MISTRAL_API_KEY=your_key
python3 verify_mistral_setup.py

# Clear caches if models missing
python3 refresh_mistral_cache.py
```

---

## 🔐 Security
- **No API keys** in this repo.
- **No project-specific data** (no quantum receipts, no clinical IP).
- Purely Hermes/Mistral operational knowledge.

---

*Last verified: 2026-08-25 with Hermes Agent (default profile), Mistral provider, mistral-large-latest.*
