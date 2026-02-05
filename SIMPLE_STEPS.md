# VoiceDetect - 5 MINUTE DEPLOYMENT

## Do These 5 Things in Order

### STEP 1: Create GitHub Account (2 min)
```
1. Go to github.com
2. Click "Sign up"
3. Create account with your email
```

### STEP 2: Create Repository (2 min)
```
1. Go to github.com/new
2. Name: voicedetect
3. Make it PUBLIC
4. Click "Create"
```

### STEP 3: Upload Your Code (3 min)

**Copy-paste this in your computer's terminal** (in the voicedetect project folder):

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_GITHUB_USERNAME/voicedetect.git
git push -u origin main
```

**Note**: Replace `YOUR_GITHUB_USERNAME` with your actual GitHub username

### STEP 4: Deploy on Railway (2 min)
```
1. Go to railway.app
2. Click "Login"
3. Click "GitHub" button
4. Say "Yes" to authorize
5. Click "New Project"
6. Click "Deploy from GitHub repo"
7. Find and select: voicedetect
8. Wait 3 minutes...
9. ✓ DONE!
```

### STEP 5: Get Your API URL (1 min)
```
1. Go to your Railway dashboard
2. Click on "voicedetect" project
3. Look for your domain: https://voicedetect-production-xxxx.railway.app
4. This is your API URL!
```

---

## Test Your API

Copy-paste this command in terminal (replace xxxx with your actual URL):

```bash
curl -X POST https://voicedetect-production-xxxx.railway.app/api/voice-detection \
  -H "x-api-key: AIzaSyAF6-GqFAhx3Yq8U5voaGYmdgRZ-42vbfA" \
  -H "Content-Type: application/json" \
  -d '{
    "language":"English",
    "audioFormat":"mp3",
    "audioBase64":"SUQzBAAAAAAAI1RTU0VAAAAPAAADTGF2ZjU4LjI5LjEwMAAAAAAAAAAAAAAA//NJZAA=="
  }'
```

**You should get back:**
```json
{
  "status": "success",
  "language": "English",
  "classification": "HUMAN",
  "confidenceScore": 0.92,
  "explanation": "..."
}
```

**If you got this = Your API is working! ✓**

---

## Submit This Information

When it's time to submit, provide:

**API URL:**
```
https://voicedetect-production-xxxx.railway.app/api/voice-detection
```

**API Key:**
```
AIzaSyAF6-GqFAhx3Yq8U5voaGYmdgRZ-42vbfA
```

**Example Request:**
```bash
curl -X POST https://your-url/api/voice-detection \
  -H "x-api-key: AIzaSyAF6-GqFAhx3Yq8U5voaGYmdgRZ-42vbfA" \
  -H "Content-Type: application/json" \
  -d '{"language":"English","audioFormat":"mp3","audioBase64":"BASE64_DATA"}'
```

---

## That's It!

Your API is now:
✓ Free
✓ Live 24/7
✓ On a custom domain
✓ Ready to submit

**Total time: 10 minutes**  
**Cost: $0**  
**Effort: Very easy**

---

## Need Help?

- **Deployment failed?** Check RAILWAY_DEPLOYMENT.md
- **API not working?** Run the test command above
- **Can't find your URL?** Go to railway.app → your project → deployments
- **Need custom domain?** Read RAILWAY_DEPLOYMENT.md (Section 4)

---

## Questions?

- GitHub problems: Ask ChatGPT or GitHub support
- Railway problems: Ask Railway support (very helpful)
- API problems: Check RAILWAY_DEPLOYMENT.md "Troubleshooting"

**You've got this! 🚀**
