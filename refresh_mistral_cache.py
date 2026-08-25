#!/usr/bin/env python3
"""Clear stale Hermes model caches to trigger fresh Mistral discovery."""
from pathlib import Path

HERMES_HOME = Path.home() / '.hermes'
CACHES = [
    HERMES_HOME / 'models_dev_cache.json',
    HERMES_HOME / 'provider_models_cache.json',
]

for c in CACHES:
    if c.exists():
        c.unlink()
        print(f"Removed: {c}")
    else:
        print(f"Already clean: {c}")

print("Done. Restart Hermes to trigger fresh model discovery.")
