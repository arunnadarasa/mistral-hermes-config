#!/usr/bin/env python3
"""Verify Mistral + Hermes setup end-to-end."""
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
        for m in models[:8]:
            print(f"  - {m}")
        return True
    except Exception as e:
        print(f"❌ Model fetch failed: {e}")
        return False

def test_inference():
    try:
        result = subprocess.run(
            ['hermes', '-m', 'mistral-large-latest', '--provider', 'mistral',
             '-z', 'Say "Mistral is ready" in one sentence.'],
            capture_output=True, text=True, timeout=60
        )
        if result.returncode == 0:
            print(f"✅ Inference test passed: {result.stdout.strip()[:120]}")
            return True
        else:
            print(f"❌ Inference failed: {result.stderr[:200]}")
            return False
    except Exception as e:
        print(f"❌ Inference test error: {e}")
        return False

if __name__ == '__main__':
    ok = all([check_key(), check_models(), test_inference()])
    print(f"\n{'='*40}\n{'ALL CHECKS PASSED' if ok else 'SOME CHECKS FAILED'}")
    sys.exit(0 if ok else 1)
