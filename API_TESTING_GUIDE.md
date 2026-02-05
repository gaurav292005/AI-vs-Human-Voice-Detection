# VoiceDetect - Complete JSON API Testing Guide

## Quick Start Testing

### Test 1: Check API is Running (GET Request)

**Using curl:**
```bash
curl http://localhost:3000/api/detect
```

**Expected Response (200 OK):**
```json
{
  "status": "success",
  "data": {
    "endpoint": "/api/detect",
    "method": "POST",
    "description": "Analyze audio file for voice authenticity verification",
    "authentication": {
      "type": "API Key",
      "header": "X-API-Key"
    },
    "request": {
      "contentType": "application/json",
      "body": {
        "audio": "string (base64-encoded MP3 data)",
        "language": "string (optional: en, hi, ta, te, ml)"
      }
    },
    "response": {...}
  }
}
```

---

## Testing JSON Error Scenarios

### Test 2: Missing API Key

**Request:**
```bash
curl -X POST http://localhost:3000/api/detect \
  -H "Content-Type: application/json" \
  -d '{"audio":"test","language":"en"}'
```

**Expected Response (401 Unauthorized):**
```json
{
  "status": "error",
  "error": "Missing API key",
  "code": "MISSING_API_KEY",
  "message": "X-API-Key header is required"
}
```

---

### Test 3: Invalid API Key

**Request:**
```bash
curl -X POST http://localhost:3000/api/detect \
  -H "X-API-Key: wrong-key" \
  -H "Content-Type: application/json" \
  -d '{"audio":"test","language":"en"}'
```

**Expected Response (401 Unauthorized):**
```json
{
  "status": "error",
  "error": "Invalid API key",
  "code": "INVALID_API_KEY",
  "message": "The provided API key is not valid"
}
```

---

### Test 4: Invalid JSON

**Request:**
```bash
curl -X POST http://localhost:3000/api/detect \
  -H "X-API-Key: voice-detect-2024" \
  -H "Content-Type: application/json" \
  -d '{invalid json}'
```

**Expected Response (400 Bad Request):**
```json
{
  "status": "error",
  "error": "Invalid JSON",
  "code": "INVALID_JSON",
  "message": "Request body must be valid JSON"
}
```

---

### Test 5: Missing Audio Field

**Request:**
```bash
curl -X POST http://localhost:3000/api/detect \
  -H "X-API-Key: voice-detect-2024" \
  -H "Content-Type: application/json" \
  -d '{"language":"en"}'
```

**Expected Response (400 Bad Request):**
```json
{
  "status": "error",
  "error": "Missing audio data",
  "code": "MISSING_AUDIO",
  "message": "Request body must include 'audio' field with base64-encoded MP3 data"
}
```

---

### Test 6: Invalid Audio Format (Not String)

**Request:**
```bash
curl -X POST http://localhost:3000/api/detect \
  -H "X-API-Key: voice-detect-2024" \
  -H "Content-Type: application/json" \
  -d '{"audio":123,"language":"en"}'
```

**Expected Response (400 Bad Request):**
```json
{
  "status": "error",
  "error": "Invalid audio format",
  "code": "INVALID_AUDIO_FORMAT",
  "message": "Audio field must be a string (base64-encoded)"
}
```

---

### Test 7: Invalid Language

**Request:**
```bash
curl -X POST http://localhost:3000/api/detect \
  -H "X-API-Key: voice-detect-2024" \
  -H "Content-Type: application/json" \
  -d '{"audio":"SUQzBAAAAAAAI1RTU0U...","language":"fr"}'
```

**Expected Response (400 Bad Request):**
```json
{
  "status": "error",
  "error": "Invalid language",
  "code": "INVALID_LANGUAGE",
  "message": "Language must be one of: en, hi, ta, te, ml"
}
```

---

### Test 8: Audio Too Large

**Request:**
```bash
# Create large base64 data (>10MB)
curl -X POST http://localhost:3000/api/detect \
  -H "X-API-Key: voice-detect-2024" \
  -H "Content-Type: application/json" \
  -d '{"audio":"<10MB+ base64 data>","language":"en"}'
```

**Expected Response (413 Payload Too Large):**
```json
{
  "status": "error",
  "error": "Audio file too large",
  "code": "AUDIO_TOO_LARGE",
  "message": "Base64-encoded audio cannot exceed 10MB"
}
```

---

## Testing Successful Requests

### Test 9: Successful Analysis (English)

**Request:**
```bash
curl -X POST http://localhost:3000/api/detect \
  -H "X-API-Key: voice-detect-2024" \
  -H "Content-Type: application/json" \
  -d '{
    "audio": "SUQzBAAAAAAAI1RTU0VAAAAPAAADTGF2ZjU4LjI5LjEwMAAAAAAAAAAAAAAA//NJZAA=",
    "language": "en"
  }'
```

**Expected Response (200 OK):**
```json
{
  "status": "success",
  "data": {
    "classification": "HUMAN",
    "confidence": 0.92,
    "explanation": "Detected natural vocal imperfections including pitch microfluctuations...",
    "detected_language": "English",
    "processing_time_ms": 245
  }
}
```

---

### Test 10: Analysis with Different Languages

**Test Language: Hindi**
```bash
curl -X POST http://localhost:3000/api/detect \
  -H "X-API-Key: voice-detect-2024" \
  -H "Content-Type: application/json" \
  -d '{"audio":"SUQzBAAAAAAAI1RTU0U...","language":"hi"}'
```

**Response includes:**
```json
{
  "status": "success",
  "data": {
    "classification": "HUMAN",
    "confidence": 0.88,
    "explanation": "...",
    "detected_language": "Hindi",
    "processing_time_ms": 267
  }
}
```

**Test Language: Tamil**
```bash
curl -X POST http://localhost:3000/api/detect \
  -H "X-API-Key: voice-detect-2024" \
  -H "Content-Type: application/json" \
  -d '{"audio":"SUQzBAAAAAAAI1RTU0U...","language":"ta"}'
```

**Test Language: Telugu**
```bash
curl -X POST http://localhost:3000/api/detect \
  -H "X-API-Key: voice-detect-2024" \
  -H "Content-Type: application/json" \
  -d '{"audio":"SUQzBAAAAAAAI1RTU0U...","language":"te"}'
```

**Test Language: Malayalam**
```bash
curl -X POST http://localhost:3000/api/detect \
  -H "X-API-Key: voice-detect-2024" \
  -H "Content-Type: application/json" \
  -d '{"audio":"SUQzBAAAAAAAI1RTU0U...","language":"ml"}'
```

---

## Testing with Postman

### Import Collection JSON

Create file: `VoiceDetect.postman_collection.json`

```json
{
  "info": {
    "name": "VoiceDetect API - JSON Format",
    "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
  },
  "item": [
    {
      "name": "GET - API Documentation",
      "request": {
        "method": "GET",
        "header": [],
        "url": {
          "raw": "{{base_url}}/api/detect",
          "host": ["{{base_url}}"],
          "path": ["api", "detect"]
        }
      }
    },
    {
      "name": "POST - Successful Analysis",
      "request": {
        "method": "POST",
        "header": [
          {
            "key": "X-API-Key",
            "value": "voice-detect-2024",
            "type": "text"
          },
          {
            "key": "Content-Type",
            "value": "application/json",
            "type": "text"
          }
        ],
        "body": {
          "mode": "raw",
          "raw": "{\"audio\":\"SUQzBAAAAAAAI1RTU0U...\",\"language\":\"en\"}"
        },
        "url": {
          "raw": "{{base_url}}/api/detect",
          "host": ["{{base_url}}"],
          "path": ["api", "detect"]
        }
      }
    },
    {
      "name": "POST - Missing API Key",
      "request": {
        "method": "POST",
        "header": [
          {
            "key": "Content-Type",
            "value": "application/json",
            "type": "text"
          }
        ],
        "body": {
          "mode": "raw",
          "raw": "{\"audio\":\"test\",\"language\":\"en\"}"
        },
        "url": {
          "raw": "{{base_url}}/api/detect",
          "host": ["{{base_url}}"],
          "path": ["api", "detect"]
        }
      }
    },
    {
      "name": "POST - Invalid API Key",
      "request": {
        "method": "POST",
        "header": [
          {
            "key": "X-API-Key",
            "value": "wrong-key",
            "type": "text"
          },
          {
            "key": "Content-Type",
            "value": "application/json",
            "type": "text"
          }
        ],
        "body": {
          "mode": "raw",
          "raw": "{\"audio\":\"test\",\"language\":\"en\"}"
        },
        "url": {
          "raw": "{{base_url}}/api/detect",
          "host": ["{{base_url}}"],
          "path": ["api", "detect"]
        }
      }
    },
    {
      "name": "POST - Missing Audio",
      "request": {
        "method": "POST",
        "header": [
          {
            "key": "X-API-Key",
            "value": "voice-detect-2024",
            "type": "text"
          },
          {
            "key": "Content-Type",
            "value": "application/json",
            "type": "text"
          }
        ],
        "body": {
          "mode": "raw",
          "raw": "{\"language\":\"en\"}"
        },
        "url": {
          "raw": "{{base_url}}/api/detect",
          "host": ["{{base_url}}"],
          "path": ["api", "detect"]
        }
      }
    }
  ],
  "variable": [
    {
      "key": "base_url",
      "value": "http://localhost:3000",
      "type": "string"
    }
  ]
}
```

**Steps to use:**
1. Open Postman
2. Click "Import"
3. Paste the collection JSON
4. Update `base_url` variable
5. Run each test request

---

## Testing with Node.js

**Create `test-api.js`:**

```javascript
const http = require('http');

function testAPI(testName, method, path, headers, body) {
  return new Promise((resolve) => {
    console.log(`\n===== ${testName} =====`);
    
    const options = {
      hostname: 'localhost',
      port: 3000,
      path: path,
      method: method,
      headers: {
        'Content-Type': 'application/json',
        ...headers
      }
    };

    const req = http.request(options, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => {
        console.log(`Status: ${res.statusCode}`);
        try {
          const response = JSON.parse(data);
          console.log('Response:', JSON.stringify(response, null, 2));
        } catch {
          console.log('Response:', data);
        }
        resolve();
      });
    });

    req.on('error', (e) => {
      console.error(`Error: ${e.message}`);
      resolve();
    });

    if (body) req.write(JSON.stringify(body));
    req.end();
  });
}

async function runTests() {
  console.log('Starting VoiceDetect API Tests (JSON Format)\n');

  // Test 1: GET documentation
  await testAPI('GET API Documentation', 'GET', '/api/detect');

  // Test 2: Missing API key
  await testAPI('Missing API Key', 'POST', '/api/detect', {}, 
    { audio: 'test', language: 'en' });

  // Test 3: Invalid API key
  await testAPI('Invalid API Key', 'POST', '/api/detect', 
    { 'X-API-Key': 'wrong' }, 
    { audio: 'test', language: 'en' });

  // Test 4: Missing audio
  await testAPI('Missing Audio', 'POST', '/api/detect', 
    { 'X-API-Key': 'voice-detect-2024' }, 
    { language: 'en' });

  // Test 5: Invalid language
  await testAPI('Invalid Language', 'POST', '/api/detect', 
    { 'X-API-Key': 'voice-detect-2024' }, 
    { audio: 'SUQzBAA...', language: 'fr' });

  // Test 6: Successful request
  await testAPI('Successful Analysis', 'POST', '/api/detect', 
    { 'X-API-Key': 'voice-detect-2024' }, 
    { audio: 'SUQzBAAAAAAAI1RTU0U...', language: 'en' });

  console.log('\n===== All Tests Complete =====\n');
}

runTests();
```

**Run tests:**
```bash
node test-api.js
```

---

## Testing with Python

**Create `test_api.py`:**

```python
import requests
import json

BASE_URL = 'http://localhost:3000/api/detect'
API_KEY = 'voice-detect-2024'

def test_api(test_name, method='GET', headers=None, data=None):
    print(f'\n===== {test_name} =====')
    
    if headers is None:
        headers = {}
    
    headers['Content-Type'] = 'application/json'
    
    try:
        if method == 'GET':
            response = requests.get(BASE_URL, headers=headers)
        else:
            response = requests.post(BASE_URL, headers=headers, json=data)
        
        print(f'Status: {response.status_code}')
        print(f'Response: {json.dumps(response.json(), indent=2)}')
    except Exception as e:
        print(f'Error: {str(e)}')

def run_tests():
    print('Starting VoiceDetect API Tests (JSON Format)\n')
    
    # Test 1: GET documentation
    test_api('GET API Documentation')
    
    # Test 2: Missing API key
    test_api('Missing API Key', method='POST', data={'audio': 'test', 'language': 'en'})
    
    # Test 3: Invalid API key
    test_api('Invalid API Key', method='POST', 
             headers={'X-API-Key': 'wrong'}, 
             data={'audio': 'test', 'language': 'en'})
    
    # Test 4: Missing audio
    test_api('Missing Audio', method='POST',
             headers={'X-API-Key': API_KEY},
             data={'language': 'en'})
    
    # Test 5: Invalid language
    test_api('Invalid Language', method='POST',
             headers={'X-API-Key': API_KEY},
             data={'audio': 'SUQzBAA...', 'language': 'fr'})
    
    # Test 6: Successful request
    test_api('Successful Analysis', method='POST',
             headers={'X-API-Key': API_KEY},
             data={'audio': 'SUQzBAAAAAAAI1RTU0U...', 'language': 'en'})
    
    print('\n===== All Tests Complete =====\n')

if __name__ == '__main__':
    run_tests()
```

**Run tests:**
```bash
pip install requests
python test_api.py
```

---

## JSON Response Validation

### Checklist for All Responses

✓ All responses have `status` field  
✓ Status is either "success" or "error"  
✓ Success responses have `data` field  
✓ Error responses have `error`, `code`, `message` fields  
✓ HTTP status code matches response type  
✓ JSON is valid and parseable  
✓ No malformed JSON  
✓ All required fields present  
✓ Data types are correct  

### Success Response Validation

```javascript
// Validate success response
function validateSuccessResponse(response) {
  if (response.status !== 'success') throw new Error('Invalid status');
  if (!response.data) throw new Error('Missing data field');
  if (!response.data.classification) throw new Error('Missing classification');
  if (typeof response.data.confidence !== 'number') throw new Error('Invalid confidence');
  if (response.data.confidence < 0 || response.data.confidence > 1) throw new Error('Confidence out of range');
  if (!response.data.explanation) throw new Error('Missing explanation');
  if (!response.data.detected_language) throw new Error('Missing language');
  if (typeof response.data.processing_time_ms !== 'number') throw new Error('Invalid processing time');
  return true;
}
```

### Error Response Validation

```javascript
// Validate error response
function validateErrorResponse(response) {
  if (response.status !== 'error') throw new Error('Invalid status');
  if (!response.error) throw new Error('Missing error field');
  if (!response.code) throw new Error('Missing code field');
  if (!response.message) throw new Error('Missing message field');
  return true;
}
```

---

## Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| 404 Not Found | Ensure server is running and endpoint is `/api/detect` |
| 405 Method Not Allowed | Use GET for docs, POST for analysis |
| 400 Bad Request | Check JSON syntax and required fields |
| 401 Unauthorized | Verify X-API-Key header is correct |
| CORS Error | API requires proper CORS headers for browser |
| Invalid JSON | Check JSON format with JSONLint |

---

## Performance Metrics

**Expected Performance:**
- Response Time: 200-400ms
- Processing Time: 120-300ms
- Success Rate: 99.9%
- JSON Parsing: <10ms

---

## Ready to Test!

All responses are in **JSON format** with consistent structure. Start with Test 1 and work through all tests to verify your API implementation.

