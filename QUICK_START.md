# Quick Start - Submission Ready

## 5-Minute Setup

### 1. Deploy to Vercel
```bash
vercel deploy --prod
```

### 2. Set API Key in Vercel Dashboard
1. Go to: **Vercel Project → Settings → Environment Variables**
2. Add: `VOICEGUARD_API_KEY=your-secure-key-here`
3. Redeploy or environment takes effect automatically

### 3. Get Your Endpoint URL
```bash
# From Vercel dashboard
# Copy: https://your-project-name.vercel.app
```

### 4. Test the Endpoint
```bash
curl -X POST https://your-project-name.vercel.app/api/detect \
  -H "Authorization: Bearer your-secure-key-here" \
  -H "Content-Type: application/json" \
  -d '{
    "audio": "SUQzBAAAAAAAI1RTU0VAAAAPAAADTGF2ZjU4LjI5LjEwMAAAAAAAAAAAAAAA//NJZAA==",
    "language": "en"
  }'
```

Expected Response:
```json
{
  "classification": "AI_GENERATED",
  "confidence": 0.92,
  "explanation": "The audio sample exhibits consistent pitch patterns...",
  "detected_language": "English",
  "processing_time_ms": 145
}
```

---

## API Key Generation

Generate a strong API key:
```bash
# macOS/Linux
openssl rand -hex 32

# Windows PowerShell
[System.Convert]::ToBase64String((1..32 | ForEach-Object {Get-Random -Maximum 256}) | %{[byte]$_}) | head -c 44

# Node.js (cross-platform)
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
```

Example output:
```
a7f9e8d4c1b2f3e5a6g7h8i9j0k1l2m3n4o5p6q7r8s9t0u1v2w3x4y5z6
```

---

## Test Suite

### Test 1: Valid Request (Should Return 200)
```bash
#!/bin/bash
API_KEY="your-api-key-here"
ENDPOINT="https://your-project.vercel.app/api/detect"

# Sample audio data (empty MP3 header)
AUDIO_BASE64="SUQzBAAAAAAAI1RTU0VAAAAPAAADTGF2ZjU4LjI5LjEwMAAAAAAAAAAAAAAA//NJZAA=="

curl -X POST "$ENDPOINT" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d "{
    \"audio\": \"$AUDIO_BASE64\",
    \"language\": \"en\"
  }"
```

### Test 2: Missing API Key (Should Return 401)
```bash
ENDPOINT="https://your-project.vercel.app/api/detect"
AUDIO_BASE64="SUQzBAAAAAAAI1RTU0VAAAAPAAADTGF2ZjU4LjI5LjEwMAAAAAAAAAAAAAAA//NJZAA=="

curl -X POST "$ENDPOINT" \
  -H "Content-Type: application/json" \
  -d "{
    \"audio\": \"$AUDIO_BASE64\"
  }"

# Expected: {"error": "Unauthorized: Invalid or missing API key"}
```

### Test 3: No Audio Data (Should Return 400)
```bash
API_KEY="your-api-key-here"
ENDPOINT="https://your-project.vercel.app/api/detect"

curl -X POST "$ENDPOINT" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d "{}"

# Expected: {"error": "No audio data provided"}
```

### Test 4: Invalid Language (Should Return 400)
```bash
API_KEY="your-api-key-here"
ENDPOINT="https://your-project.vercel.app/api/detect"
AUDIO_BASE64="SUQzBAAAAAAAI1RTU0VAAAAPAAADTGF2ZjU4LjI5LjEwMAAAAAAAAAAAAAAA//NJZAA=="

curl -X POST "$ENDPOINT" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d "{
    \"audio\": \"$AUDIO_BASE64\",
    \"language\": \"invalid\"
  }"

# Expected: {"error": "Invalid language. Supported: en, hi, ta, te, ml"}
```

### Test 5: All Supported Languages
```bash
#!/bin/bash
API_KEY="your-api-key-here"
ENDPOINT="https://your-project.vercel.app/api/detect"
AUDIO_BASE64="SUQzBAAAAAAAI1RTU0VAAAAPAAADTGF2ZjU4LjI5LjEwMAAAAAAAAAAAAAAA//NJZAA=="

LANGUAGES=("en" "hi" "ta" "te" "ml")

for lang in "${LANGUAGES[@]}"; do
  echo "Testing language: $lang"
  curl -X POST "$ENDPOINT" \
    -H "Authorization: Bearer $API_KEY" \
    -H "Content-Type: application/json" \
    -d "{
      \"audio\": \"$AUDIO_BASE64\",
      \"language\": \"$lang\"
    }"
  echo ""
done
```

---

## Python Client Example

```python
import requests
import base64
import json

class VoiceGuardClient:
    def __init__(self, endpoint: str, api_key: str):
        self.endpoint = endpoint
        self.api_key = api_key
    
    def detect(self, audio_path: str, language: str = None):
        """Detect if voice is AI-generated or human"""
        
        # Read and encode audio file
        with open(audio_path, 'rb') as f:
            audio_base64 = base64.b64encode(f.read()).decode('utf-8')
        
        # Prepare request
        headers = {
            "Authorization": f"Bearer {self.api_key}",
            "Content-Type": "application/json"
        }
        
        payload = {"audio": audio_base64}
        if language:
            payload["language"] = language
        
        # Send request
        response = requests.post(
            f"{self.endpoint}/api/detect",
            headers=headers,
            json=payload
        )
        
        # Handle response
        if response.status_code == 200:
            return response.json()
        elif response.status_code == 401:
            raise Exception("Unauthorized: Invalid API key")
        elif response.status_code == 400:
            raise Exception(f"Bad request: {response.json()['error']}")
        else:
            raise Exception(f"Error: {response.status_code}")

# Usage
if __name__ == "__main__":
    client = VoiceGuardClient(
        endpoint="https://your-project.vercel.app",
        api_key="your-api-key-here"
    )
    
    result = client.detect("sample.mp3", language="en")
    
    print(f"Classification: {result['classification']}")
    print(f"Confidence: {result['confidence']}")
    print(f"Explanation: {result['explanation']}")
    print(f"Processing Time: {result['processing_time_ms']}ms")
```

---

## JavaScript/Node.js Client Example

```javascript
class VoiceGuardClient {
  constructor(endpoint, apiKey) {
    this.endpoint = endpoint;
    this.apiKey = apiKey;
  }

  async detect(audioPath, language = null) {
    const fs = require('fs');
    const audioBuffer = fs.readFileSync(audioPath);
    const audioBase64 = audioBuffer.toString('base64');

    const payload = { audio: audioBase64 };
    if (language) payload.language = language;

    const response = await fetch(`${this.endpoint}/api/detect`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${this.apiKey}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(payload)
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || `HTTP ${response.status}`);
    }

    return response.json();
  }
}

// Usage
const client = new VoiceGuardClient(
  'https://your-project.vercel.app',
  'your-api-key-here'
);

client.detect('sample.mp3', 'en')
  .then(result => {
    console.log('Classification:', result.classification);
    console.log('Confidence:', result.confidence);
    console.log('Processing Time:', result.processing_time_ms + 'ms');
  })
  .catch(error => console.error('Error:', error.message));
```

---

## TypeScript Types

```typescript
type Classification = 'AI_GENERATED' | 'HUMAN';
type LanguageCode = 'en' | 'hi' | 'ta' | 'te' | 'ml';

interface DetectionRequest {
  audio: string; // Base64-encoded audio
  language?: LanguageCode;
}

interface DetectionResponse {
  classification: Classification;
  confidence: number; // 0.0 to 1.0
  explanation: string;
  detected_language: string;
  processing_time_ms: number;
}

interface ErrorResponse {
  error: string;
}
```

---

## HTTP Status Codes

| Code | Meaning | Example |
|------|---------|---------|
| 200 | Success | Valid request processed |
| 400 | Bad Request | Missing audio, invalid format |
| 401 | Unauthorized | Missing/invalid API key |
| 413 | Payload Too Large | Audio >10MB |
| 500 | Server Error | Processing failed |

---

## Submission Checklist

- [ ] Endpoint deployed on Vercel
- [ ] API key configured in environment
- [ ] Test cases pass locally
- [ ] Response format verified
- [ ] Documentation complete
- [ ] Ready for submission

**Endpoint URL:** `https://your-project-name.vercel.app/api/detect`

**API Key:** Set in VOICEGUARD_API_KEY environment variable

**Problem:** AI-Generated Voice Detection

---

*Version: 1.0 | Status: Ready | Date: Feb 4, 2026*
