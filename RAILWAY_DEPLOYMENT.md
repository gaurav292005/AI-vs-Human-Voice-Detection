# Deploy VoiceDetect on Railway.app (FREE)

**Total Time: 5 minutes**  
**Cost: $0 (free tier)**  
**URL: You'll get: `your-project.railway.app`**

---

## Step 1: Create GitHub Repository (5 minutes)

### 1.1 Create GitHub Account (if you don't have one)
- Go to github.com
- Click "Sign up"
- Complete signup

### 1.2 Create New Repository
- Go to github.com/new
- **Repository name**: `voicedetect` (or any name)
- **Description**: Voice Detection API
- **Public**: Yes (important for Railway)
- Click "Create repository"

### 1.3 Upload Your Code
You have 2 options:

**Option A: Using Git Commands**
```bash
# In your project folder
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/voicedetect.git
git push -u origin main
```

**Option B: Using GitHub Desktop**
1. Download GitHub Desktop
2. File → New Repository
3. Select your project folder
4. Create
5. Publish to GitHub

---

## Step 2: Deploy on Railway (3 minutes)

### 2.1 Create Railway Account
- Go to railway.app
- Click "Login"
- Click "GitHub" (authenticate with GitHub)
- Authorize Railway to access GitHub

### 2.2 Deploy Your Repository
1. After login, click **"New Project"** (or **"Create"** button)
2. Click **"Deploy from GitHub repo"**
3. Search for your repo: `voicedetect`
4. Click to select it
5. **Railway will auto-detect** that it's a Next.js project
6. Wait 2-3 minutes for deployment

### 2.3 Get Your URL
Once deployment finishes:
1. Go to your Railway project dashboard
2. Click **"Deployments"**
3. Look for your deployment (green checkmark = success)
4. Click on it
5. You'll see: **`https://voicedetect-production-xxxx.railway.app`**
6. This is your API URL!

---

## Step 3: Test Your API (2 minutes)

### 3.1 Test Endpoint
```bash
curl -X POST https://voicedetect-production-xxxx.railway.app/api/voice-detection \
  -H "x-api-key: sk_test_123456789" \
  -H "Content-Type: application/json" \
  -d '{
    "language":"English",
    "audioFormat":"mp3",
    "audioBase64":"SUQzBAAAAAAAI1RTU0VAAAAPAAADTGF2ZjU4LjI5LjEwMAAAAAAAAAAAAAAA//NJZAA=="
  }'
```

### 3.2 Expected Response
```json
{
  "status": "success",
  "language": "English",
  "classification": "HUMAN",
  "confidenceScore": 0.92,
  "explanation": "Natural pitch fluctuations and authentic vocal quality detected"
}
```

If you get this, **your API is working!** ✓

---

## Step 4: Setup Custom Domain (Optional but Recommended)

### 4.1 Get Free Domain
You have options:
1. **Free domain from Freenom** (freenom.com)
   - Free but expires yearly (renew free)
   - Works with Railway
   
2. **Cheap domain** (Namecheap: $0.88/year)
   - More reliable than free
   
3. **Use Railway's default** (voicedetect-production-xxxx.railway.app)
   - Works fine for submission

### 4.2 Connect Domain to Railway
If you have a custom domain:
1. In Railway dashboard, go to **Settings**
2. Click **"Domain"**
3. Enter your custom domain
4. Follow DNS instructions
5. HTTPS is automatic!

---

## Step 5: Prepare for Submission

### 5.1 Your Submission Information
**Copy this information:**
```
API Endpoint: https://voicedetect-production-xxxx.railway.app/api/voice-detection
(or your custom domain)

API Key: sk_test_123456789

Method: POST

Header: x-api-key (lowercase)
```

### 5.2 Test All 5 Languages Before Submission

```bash
# English
curl -X POST https://your-api.railway.app/api/voice-detection \
  -H "x-api-key: sk_test_123456789" \
  -H "Content-Type: application/json" \
  -d '{"language":"English","audioFormat":"mp3","audioBase64":"BASE64_DATA"}'

# Hindi
curl -X POST https://your-api.railway.app/api/voice-detection \
  -H "x-api-key: sk_test_123456789" \
  -H "Content-Type: application/json" \
  -d '{"language":"Hindi","audioFormat":"mp3","audioBase64":"BASE64_DATA"}'

# Tamil
curl -X POST https://your-api.railway.app/api/voice-detection \
  -H "x-api-key: sk_test_123456789" \
  -H "Content-Type: application/json" \
  -d '{"language":"Tamil","audioFormat":"mp3","audioBase64":"BASE64_DATA"}'

# Telugu
curl -X POST https://your-api.railway.app/api/voice-detection \
  -H "x-api-key: sk_test_123456789" \
  -H "Content-Type: application/json" \
  -d '{"language":"Telugu","audioFormat":"mp3","audioBase64":"BASE64_DATA"}'

# Malayalam
curl -X POST https://your-api.railway.app/api/voice-detection \
  -H "x-api-key: sk_test_123456789" \
  -H "Content-Type: application/json" \
  -d '{"language":"Malayalam","audioFormat":"mp3","audioBase64":"BASE64_DATA"}'
```

### 5.3 Verify Requirements Met
- [ ] API is live on custom domain (not vercel.com)
- [ ] API key header is `x-api-key` (lowercase)
- [ ] All 5 languages work
- [ ] Classification is "AI_GENERATED" or "HUMAN"
- [ ] Confidence score is 0.0-1.0
- [ ] Response includes: status, language, classification, confidenceScore, explanation
- [ ] HTTPS works
- [ ] No v0.app branding visible
- [ ] Response time < 1 second

---

## Troubleshooting

### Problem: Deployment Failed
**Solution:**
1. Check your code is on GitHub
2. Check `.gitignore` doesn't exclude important files
3. Check `package.json` exists
4. Re-trigger deployment: go to Railway → Deployments → Redeploy

### Problem: API returns 500 error
**Solution:**
1. Check environment variables in Railway
2. Check logs: Railway → Deployments → Logs tab
3. Make sure all files are committed to GitHub

### Problem: Can't connect to API
**Solution:**
1. Wait 5 minutes (Railway needs time to start)
2. Check URL is correct
3. Check API key header is lowercase: `x-api-key`
4. Try simple GET request first

### Problem: Domain not working
**Solution:**
1. Check DNS is updated (can take 24 hours)
2. Use Railway's default domain while waiting
3. HTTPS might need 5-10 minutes to activate

---

## After Deployment - What You Have

✓ **Live API**: Accessible 24/7  
✓ **Free hosting**: No payment needed  
✓ **HTTPS**: Automatic SSL certificate  
✓ **Custom domain**: Optional but recommended  
✓ **Auto-scaling**: Handles traffic automatically  
✓ **API URL**: Ready to submit  

---

## Submission Ready

Your API URL is ready to submit:
```
https://your-domain.railway.app/api/voice-detection
```

Include in submission:
- API Endpoint URL
- API Key: sk_test_123456789
- Example curl command
- All 5 languages supported

---

## Important Notes

1. **Railway Free Tier**: 
   - $5 credit per month (usually enough)
   - If you hit limit, set email alert
   - Or upgrade to paid ($5/month minimum)

2. **Keep it Running**:
   - Don't delete the Railway project
   - Don't disconnect GitHub
   - Automatic redeploy on GitHub push

3. **API Key Security**:
   - This is test key: `sk_test_123456789`
   - Don't use in production with real data
   - Change if needed in code before deployment

4. **Update Code**:
   - Make changes locally
   - Push to GitHub: `git push`
   - Railway auto-redeploys in 2 minutes

---

**You're ready! Follow these steps and your API will be live in 5 minutes.**

Next: Go to Step 1 and follow the guide! 🚀
