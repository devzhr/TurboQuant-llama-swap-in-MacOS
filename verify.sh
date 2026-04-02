#!/bin/bash

# Test request to llama-swap on port 18080
echo "Testing Qwen3.5-9B via llama-swap on port 18080..."

curl -s http://localhost:18080/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "qwen3.5-9b",
    "messages": [{"role": "user", "content": "Dis bonjour en français et présente-toi brièvement."}],
    "max_tokens": 150
  }' | python3 -m json.tool
