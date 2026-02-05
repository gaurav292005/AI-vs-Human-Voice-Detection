# VoiceDetect - Deployment Roadmap

## Phase 1: Preparation (5 minutes)

### Step 1.1: Clean Up Repository
```bash
# Remove v0 traces
rm -rf .vercel
git rm --cached vercel.json 2>/dev/null || true

# Clean git
git clean -fd
```

### Step 1.2: Verify Locally
```bash
# Install dependencies
npm install

# Test development
npm run dev
# Visit http://localhost:3000
```

### Step 1.3: Test API Locally
```bash
# In another terminal
curl -X POST http://localhost:3000/api/voice-detection \
  -H "x-api-key: sk_test_123456789" \
  -H "Content-Type: application/json" \
  -d '{
    "language":"English",
    "audioFormat":"mp3",
    "audioBase64":"SUQzBAAAAAAAI1RTU0U..."
  }'
```

---

## Phase 2: Build & Deploy (Choose One)

### Option A: Docker (Recommended - 10 minutes)

#### Step 2A.1: Build Docker Image
```bash
docker build -t voicedetect:latest .
```

#### Step 2A.2: Test Locally
```bash
docker run -p 3000:3000 voicedetect:latest
# Visit http://localhost:3000
```

#### Step 2A.3: Deploy to Cloud
**For DigitalOcean App Platform:**
```bash
# Connect your Git repo
# DigitalOcean auto-detects Dockerfile
# Auto-deploys on git push
```

**For AWS:**
```bash
# Push to ECR
# Deploy with ECS/EKS
```

**For Google Cloud:**
```bash
gcloud builds submit --tag gcr.io/PROJECT_ID/voicedetect
gcloud run deploy voicedetect --image gcr.io/PROJECT_ID/voicedetect
```

### Option B: Railway (Easiest - 5 minutes)

#### Step 2B.1: Connect GitHub
1. Go to railway.app
2. Click "New Project"
3. Select "Deploy from GitHub"
4. Choose your repository

#### Step 2B.2: Configure
- Railway auto-detects Node.js
- Auto-builds and deploys
- Provides deployment URL

#### Step 2B.3: Add Custom Domain
- Railway Dashboard → Domains
- Add your custom domain
- Enable HTTPS (automatic)

### Option C: VPS Self-Hosting (30 minutes)

See `SELF_HOSTING_GUIDE.md` for complete instructions.

#### Quick Overview:
1. SSH into VPS
2. Install Node.js
3. Clone repo
4. Build and start with PM2
5. Setup Nginx proxy
6. Configure SSL with Let's Encrypt

### Option D: Docker Compose (Local/VPS - 5 minutes)

```bash
docker-compose up -d
```

---

## Phase 3: Configure Domain (10 minutes)

### Step 3.1: Domain Setup

**For Railway/Render:**
- Add domain in dashboard
- Update DNS records
- HTTPS auto-enabled

**For VPS:**
```bash
# Point DNS to your VPS IP
# Update Nginx config
# Run certbot for SSL
```

### Step 3.2: DNS Configuration

```
Your Domain → Your Server/Platform IP
```

### Step 3.3: HTTPS Setup

**Docker/VPS:**
```bash
sudo certbot --nginx -d your-domain.com
```

**Railway/Render:**
- Auto-configured ✓

---

## Phase 4: Testing (10 minutes)

### Step 4.1: Basic Connectivity
```bash
curl https://your-domain.com/api/voice-detection
# Should show CORS error (expected)
```

### Step 4.2: API Test
```bash
curl -X POST https://your-domain.com/api/voice-detection \
  -H "x-api-key: sk_test_123456789" \
  -H "Content-Type: application/json" \
  -d '{
    "language":"English",
    "audioFormat":"mp3",
    "audioBase64":"SUQzBAA..."
  }'

# Expected response:
# {"status":"success","language":"English","classification":"HUMAN","confidenceScore":0.92,"explanation":"..."}
```

### Step 4.3: Language Testing
```bash
# Test all 5 languages
for lang in English Hindi Tamil Telugu Malayalam; do
  echo "Testing: $lang"
  curl -X POST https://your-domain.com/api/voice-detection \
    -H "x-api-key: sk_test_123456789" \
    -H "Content-Type: application/json" \
    -d "{\"language\":\"$lang\",\"audioFormat\":\"mp3\",\"audioBase64\":\"SUQzBAA...\"}"
done
```

### Step 4.4: Error Testing
```bash
# Test without API key (should return 401)
curl -X POST https://your-domain.com/api/voice-detection \
  -H "Content-Type: application/json" \
  -d '{"language":"English","audioFormat":"mp3","audioBase64":"test"}'

# Test with invalid key (should return 401)
curl -X POST https://your-domain.com/api/voice-detection \
  -H "x-api-key: invalid" \
  -H "Content-Type: application/json" \
  -d '{"language":"English","audioFormat":"mp3","audioBase64":"test"}'
```

---

## Phase 5: Prepare Submission

### Step 5.1: Gather Information

```
Endpoint URL: https://your-domain.com/api/voice-detection
API Key: sk_test_123456789 (or your custom key)
Method: POST
Header: x-api-key
```

### Step 5.2: Prepare Examples

```bash
# Example request
curl -X POST https://your-domain.com/api/voice-detection \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk_test_123456789" \
  -d '{
    "language": "English",
    "audioFormat": "mp3",
    "audioBase64": "base64-encoded-mp3-data"
  }'

# Example response
{
  "status": "success",
  "language": "English",
  "classification": "HUMAN",
  "confidenceScore": 0.92,
  "explanation": "Natural pitch fluctuations and authentic vocal quality detected"
}
```

### Step 5.3: Final Verification

- [ ] Endpoint is accessible
- [ ] HTTPS works
- [ ] API key validation works
- [ ] All 5 languages work
- [ ] Response format is correct
- [ ] Error handling works
- [ ] No v0.app branding
- [ ] Response time <1 second

---

## Phase 6: Submission

### Step 6.1: Submit Information

Provide to evaluation system:
1. Endpoint URL
2. API Key
3. Example request
4. Example response

### Step 6.2: Monitor

- Check if evaluation system can access your API
- Monitor logs for any issues
- Respond to any questions

---

## Troubleshooting

### Common Issues

| Issue | Solution |
|-------|----------|
| Port already in use | `lsof -ti:3000 \| xargs kill -9` |
| Docker not running | Start Docker Desktop or daemon |
| Domain not working | Check DNS propagation (24h) |
| HTTPS error | Wait for SSL certificate (5min) |
| API returns 500 | Check server logs |
| API returns 401 | Verify API key is correct |

### Debugging

```bash
# Check logs (Docker)
docker logs -f container-id

# Check logs (PM2)
pm2 logs voicedetect

# Test endpoint
curl -v https://your-domain.com/api/voice-detection

# Check DNS
nslookup your-domain.com
```

---

## Timeline

| Phase | Time | Tasks |
|-------|------|-------|
| Preparation | 5 min | Clean up, verify locally |
| Build & Deploy | 5-30 min | Choose option, deploy |
| Configure Domain | 10 min | Add domain, setup DNS |
| Testing | 10 min | Test all functionality |
| Prepare Submission | 5 min | Gather info, verify |
| **Total** | **35-60 min** | **Complete deployment** |

---

## Deployment Checklist

- [ ] Repository cleaned (v0 traces removed)
- [ ] Code tested locally
- [ ] Dockerfile built successfully
- [ ] Deployment option chosen
- [ ] API deployed to production
- [ ] Custom domain configured
- [ ] HTTPS enabled
- [ ] All tests passing
- [ ] No 500 errors
- [ ] Response time acceptable
- [ ] API key working
- [ ] All 5 languages working
- [ ] Error handling verified
- [ ] No v0.app branding visible
- [ ] Ready for submission

---

## Success Indicators

✅ Your deployment is successful when:

1. **Endpoint Accessible**
   ```
   https://your-domain.com/api/voice-detection → 404 (GET not supported)
   POST to endpoint → 401 (missing API key)
   POST with key → 200 (success or validation error)
   ```

2. **API Key Working**
   ```
   Invalid key → 401
   Valid key → 200 or 400 (validation error)
   ```

3. **All Languages Work**
   ```
   All 5 languages → Proper response
   All classifications → AI_GENERATED or HUMAN
   ```

4. **Response Format Correct**
   ```
   Status field present
   Language field present
   Classification field present
   Confidence score 0.0-1.0
   Explanation text present
   ```

---

## Next Actions

1. **Choose deployment option** (A, B, C, or D)
2. **Follow steps for your choice**
3. **Complete Phase 3-5**
4. **Submit to evaluation**

---

**Estimated Total Time**: 35-60 minutes from start to deployment ready

**Recommended Approach**: Option B (Railway) - Fastest & easiest

---

**Ready to deploy!** 🚀
