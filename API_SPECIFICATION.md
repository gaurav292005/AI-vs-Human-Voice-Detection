# VoiceDetect - Complete JSON API Specification

## Overview

VoiceDetect provides a comprehensive REST API for voice authenticity verification. All requests and responses use JSON format with consistent error handling.

---

## Base URL

```
http://localhost:3000/api/detect      (Development)
https://your-domain.com/api/detect    (Production)
```

---

## Authentication

All requests must include the API key in the request header.

**Header:**
```
X-API-Key: voice-detect-2024
```

**Error Response (Missing Key):**
```json
{
  "status": "error",
  "error": "Missing API key",
  "code": "MISSING_API_KEY",
  "message": "X-API-Key header is required"
}
```

---

## Endpoints

### 1. GET /api/detect - API Documentation

Returns comprehensive API documentation in JSON format.

**Request:**
```bash
curl http://localhost:3000/api/detect
```

**Response:**
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
    "response": { ... }
  }
}
```

---

### 2. POST /api/detect - Analyze Audio

Analyzes an audio file to determine voice authenticity.

**Request Headers:**
```
X-API-Key: voice-detect-2024
Content-Type: application/json
```

**Request Body:**
```json
{
  "audio": "base64-encoded-mp3-data",
  "language": "en"
}
```

**Body Fields:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `audio` | string | Yes | Base64-encoded MP3 audio data |
| `language` | string | No | Language code: en, hi, ta, te, ml (default: auto-detect) |

---

## Response Formats

### Success Response

**HTTP Status:** 200 OK

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

**Response Fields:**

| Field | Type | Description |
|-------|------|-------------|
| `status` | string | Always "success" for successful requests |
| `data` | object | Contains analysis results |
| `data.classification` | string | "HUMAN" or "GENERATED" |
| `data.confidence` | number | Confidence score (0.0 to 1.0) |
| `data.explanation` | string | Technical acoustic analysis explanation |
| `data.detected_language` | string | Detected language name |
| `data.processing_time_ms` | number | Processing time in milliseconds |

---

### Error Responses

All errors follow the same JSON format:

```json
{
  "status": "error",
  "error": "Error name",
  "code": "ERROR_CODE",
  "message": "Detailed error message"
}
```

#### Error Codes

**MISSING_API_KEY** (401)
```json
{
  "status": "error",
  "error": "Missing API key",
  "code": "MISSING_API_KEY",
  "message": "X-API-Key header is required"
}
```

**INVALID_API_KEY** (401)
```json
{
  "status": "error",
  "error": "Invalid API key",
  "code": "INVALID_API_KEY",
  "message": "The provided API key is not valid"
}
```

**INVALID_JSON** (400)
```json
{
  "status": "error",
  "error": "Invalid JSON",
  "code": "INVALID_JSON",
  "message": "Request body must be valid JSON"
}
```

**MISSING_AUDIO** (400)
```json
{
  "status": "error",
  "error": "Missing audio data",
  "code": "MISSING_AUDIO",
  "message": "Request body must include 'audio' field with base64-encoded MP3 data"
}
```

**INVALID_AUDIO_FORMAT** (400)
```json
{
  "status": "error",
  "error": "Invalid audio format",
  "code": "INVALID_AUDIO_FORMAT",
  "message": "Audio field must be a string (base64-encoded)"
}
```

**AUDIO_TOO_LARGE** (413)
```json
{
  "status": "error",
  "error": "Audio file too large",
  "code": "AUDIO_TOO_LARGE",
  "message": "Base64-encoded audio cannot exceed 10MB"
}
```

**INVALID_LANGUAGE** (400)
```json
{
  "status": "error",
  "error": "Invalid language",
  "code": "INVALID_LANGUAGE",
  "message": "Language must be one of: en, hi, ta, te, ml"
}
```

**SERVER_ERROR** (500)
```json
{
  "status": "error",
  "error": "Server error",
  "code": "SERVER_ERROR",
  "message": "Failed to process audio. Please try again later."
}
```

---

## HTTP Status Codes

| Code | Meaning | Scenario |
|------|---------|----------|
| 200 | OK | Analysis completed successfully |
| 400 | Bad Request | Invalid request body or missing required fields |
| 401 | Unauthorized | Missing or invalid API key |
| 413 | Payload Too Large | Audio file exceeds size limit |
| 500 | Internal Server Error | Server-side processing error |

---

## Examples

### Example 1: Successful Analysis (Node.js)

```javascript
const fs = require('fs');

async function analyzeVoice() {
  const audioFile = fs.readFileSync('sample.mp3');
  const base64Audio = audioFile.toString('base64');

  const response = await fetch('http://localhost:3000/api/detect', {
    method: 'POST',
    headers: {
      'X-API-Key': 'voice-detect-2024',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      audio: base64Audio,
      language: 'en'
    })
  });

  const result = await response.json();
  
  if (result.status === 'success') {
    console.log('Classification:', result.data.classification);
    console.log('Confidence:', result.data.confidence);
    console.log('Analysis:', result.data.explanation);
  } else {
    console.error('Error:', result.message);
  }
}

analyzeVoice();
```

### Example 2: Error Handling (Python)

```python
import requests
import base64
import json

def analyze_voice(audio_path, language='en'):
    with open(audio_path, 'rb') as f:
        audio_base64 = base64.b64encode(f.read()).decode()

    response = requests.post(
        'http://localhost:3000/api/detect',
        headers={
            'X-API-Key': 'voice-detect-2024',
            'Content-Type': 'application/json'
        },
        json={
            'audio': audio_base64,
            'language': language
        }
    )

    result = response.json()

    if response.status_code == 200:
        data = result['data']
        print(f"Status: {result['status']}")
        print(f"Classification: {data['classification']}")
        print(f"Confidence: {data['confidence']:.2%}")
        return data
    else:
        print(f"Error: {result['error']}")
        print(f"Code: {result['code']}")
        print(f"Message: {result['message']}")
        return None

# Usage
analyze_voice('sample.mp3', 'en')
```

### Example 3: cURL Request

```bash
# Analyze audio file
curl -X POST http://localhost:3000/api/detect \
  -H "X-API-Key: voice-detect-2024" \
  -H "Content-Type: application/json" \
  -d '{
    "audio": "SUQzBAAAAAAAI1RTU0VAAAAPAAADTGF2ZjU4...",
    "language": "en"
  }'
```

### Example 4: JavaScript Fetch with Error Handling

```javascript
async function analyzeAudio(file, language = 'en') {
  try {
    const reader = new FileReader();
    
    return new Promise((resolve, reject) => {
      reader.onload = async (e) => {
        try {
          const base64Audio = e.target.result.split(',')[1];

          const response = await fetch('/api/detect', {
            method: 'POST',
            headers: {
              'X-API-Key': 'voice-detect-2024',
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({
              audio: base64Audio,
              language: language
            })
          });

          const result = await response.json();

          if (response.ok && result.status === 'success') {
            resolve(result.data);
          } else {
            reject(new Error(result.message || 'Analysis failed'));
          }
        } catch (error) {
          reject(error);
        }
      };

      reader.onerror = () => reject(new Error('Failed to read file'));
      reader.readAsDataURL(file);
    });
  } catch (error) {
    console.error('Error:', error);
  }
}

// Usage
document.getElementById('analyzeBtn').onclick = async () => {
  const file = document.getElementById('audioFile').files[0];
  try {
    const result = await analyzeAudio(file, 'en');
    console.log('Result:', result);
  } catch (error) {
    console.error('Failed:', error.message);
  }
};
```

---

## Request/Response Examples

### Request 1: Valid Analysis Request

```http
POST /api/detect HTTP/1.1
Host: localhost:3000
X-API-Key: voice-detect-2024
Content-Type: application/json
Content-Length: 125

{
  "audio": "SUQzBAAAAAAAI1RTU0VAAAAPAAADTGF2ZjU4LjI5LjEwMAAAAAAAAAAAAAAA",
  "language": "en"
}
```

### Response 1: Successful Analysis

```http
HTTP/1.1 200 OK
Content-Type: application/json
Content-Length: 287

{
  "status": "success",
  "data": {
    "classification": "HUMAN",
    "confidence": 0.92,
    "explanation": "Detected natural vocal imperfections including pitch microfluctuations and acoustic irregularities consistent with human speech production physiology.",
    "detected_language": "English",
    "processing_time_ms": 245
  }
}
```

### Request 2: Missing API Key

```http
POST /api/detect HTTP/1.1
Host: localhost:3000
Content-Type: application/json

{
  "audio": "SUQzBAAAAAAAI1RTU0U...",
  "language": "en"
}
```

### Response 2: Authentication Error

```http
HTTP/1.1 401 Unauthorized
Content-Type: application/json

{
  "status": "error",
  "error": "Missing API key",
  "code": "MISSING_API_KEY",
  "message": "X-API-Key header is required"
}
```

---

## Language Support

### Supported Languages

| Code | Language |
|------|----------|
| `en` | English |
| `hi` | Hindi |
| `ta` | Tamil |
| `te` | Telugu |
| `ml` | Malayalam |

---

## Data Format Details

### Audio Format

- **Format:** MP3 (MPEG-1 Audio Layer III)
- **Encoding:** Base64
- **Max Size:** 10 MB (base64 encoded)
- **Sample Rate:** Any (16kHz to 48kHz recommended)
- **Duration:** Any (typically 3-60 seconds)

### Classification Values

- **HUMAN** - Voice is identified as human
- **GENERATED** - Voice is identified as AI-generated

### Confidence Score

- **Range:** 0.0 to 1.0
- **0.0:** Least confident
- **1.0:** Most confident
- **Typical Range:** 0.75 to 0.95

---

## Rate Limiting (Optional Implementation)

The API does not currently implement rate limiting, but can be added:

- **Recommended:** 100 requests per minute per API key
- **Implementation:** Use middleware or database tracking

---

## CORS Policy

For browser-based requests, ensure CORS is properly configured:

```javascript
// Enable CORS for all origins (development only)
headers: {
  'Access-Control-Allow-Origin': '*'
}
```

---

## Version Information

- **API Version:** 1.0.0
- **Last Updated:** February 2026
- **Status:** Production Ready

---

## Support & Documentation

- **Base Documentation:** See DEPLOYMENT_GUIDE.md
- **Setup Instructions:** See SETUP_GUIDE.md
- **Examples:** See API examples in this file
- **Testing:** Use provided curl/Node.js/Python examples

---

## Changelog

### Version 1.0.0 (February 2026)
- Initial release with JSON API
- Support for 5 languages
- Complete error handling
- GET endpoint for documentation
- Consistent JSON response format
