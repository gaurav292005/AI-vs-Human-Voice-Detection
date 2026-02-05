YOUR_CUSTOM_API_KEY_REFERENCE.md

# Your Custom API Key

Your unique API key for the VoiceDetect project:

```
sk_live_7f3a9e2c8b5d1f4a6c9e2d7b1a3f5c8e
```

## Where to Use This Key

### When Testing Locally:
```bash
curl -X POST http://localhost:3000/api/voice-detection \
  -H "x-api-key: sk_live_7f3a9e2c8b5d1f4a6c9e2d7b1a3f5c8e" \
  -H "Content-Type: application/json" \
  -d '{
    "language":"English",
    "audioFormat":"mp3",
    "audioBase64":"..."
  }'
```

### When Testing on Railway:
```bash
curl -X POST https://voicedetect-production-xxxx.railway.app/api/voice-detection \
  -H "x-api-key: sk_live_7f3a9e2c8b5d1f4a6c9e2d7b1a3f5c8e" \
  -H "Content-Type: application/json" \
  -d '{
    "language":"English",
    "audioFormat":"mp3",
    "audioBase64":"..."
  }'
```

### When Submitting:
Provide this key to the evaluators:
```
API Key: sk_live_7f3a9e2c8b5d1f4a6c9e2d7b1a3f5c8e
```

## Important Notes:
- This key has been set in your code
- Use it in the `x-api-key` header (lowercase)
- Keep this safe and don't share it publicly
- It's different from the test key (sk_test_123456789)
- Your API will only accept this key

## Files Updated With This Key:
✓ app/api/voice-detection/route.ts
✓ app/page.tsx (frontend test UI)
✓ All documentation files
