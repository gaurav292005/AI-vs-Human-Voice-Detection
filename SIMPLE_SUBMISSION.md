# 🎯 SUBMIT YOUR API - SIMPLE STEPS

---

## What You Need to Submit

1. **API Link** (your website endpoint)
2. **API Key** (password for your API)

---

## Step 1: Get API Key (1 minute)

Copy and paste this command in your computer terminal:

```bash
openssl rand -hex 32
```

It will show you something like:
```
f4e9a7c2b1d8f3e5a9c7e2b4d1f8a3c5e7b2d4f6a8c1e3b5d7f9a2c4e6b8d0
```

**Copy this key and save it somewhere safe!**

---

## Step 2: Deploy Your Website (2 minutes)

Your API is already built and ready to deploy.

### Open Terminal and Run:

```bash
vercel --prod
```

It will ask some questions - just press Enter for all of them.

When done, you will see something like:
```
✓ Production: https://v0-ai-voice-detection-api.vercel.app
```

**Copy this URL - this is your API endpoint!**

---

## Step 3: Add API Key to Vercel (2 minutes)

1. Go to: **https://vercel.com/dashboard**
2. Click your **v0-ai-voice-detection-api** project
3. Click **Settings**
4. Click **Environment Variables**
5. Click **Add New**
6. Type:
   - Name: `VOICEGUARD_API_KEY`
   - Value: (paste your API key from Step 1)
7. Click **Save**
8. Click **Redeploy** button

Wait 2-3 minutes...

---

## Step 4: Test Your API Works (1 minute)

Copy this command and replace:
- `YOUR_API_KEY` → paste your API key from Step 1
- `YOUR_URL` → paste your URL from Step 2

```bash
curl -X POST https://YOUR_URL/api/detect \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"audio":"SUQzBAAAAAAAI1RTU0VAAAAPAAADTGF2ZjU4LjI5LjEwMAAAAAAAAAAAAAAA//NJZAA==","language":"en"}'
```

**If it works**, you will see:
```json
{
  "classification": "AI_GENERATED",
  "confidence": 0.92,
  "explanation": "...",
  "detected_language": "English",
  "processing_time_ms": 145
}
```

**If it shows error**, check:
- API key is correct
- URL is correct
- You waited 2-3 minutes after redeploy

---

## Step 5: Submit to Evaluation (1 minute)

Go to the evaluation system and submit:

**Endpoint URL:**
```
https://YOUR_URL/api/detect
```

**API Key:**
```
YOUR_API_KEY
```

**Done! ✅**

---

## What Happens Next?

The evaluation system will:
1. Send audio files to your API
2. Check if you respond correctly
3. Score your results
4. Move you to next round

---

## Need Help?

### If API key doesn't work:
- Go to Vercel → Settings → Environment Variables
- Check name is exactly: `VOICEGUARD_API_KEY`
- Click **Redeploy**
- Wait 2-3 minutes

### If URL doesn't work:
- Check URL from `vercel --prod` output
- Make sure it says `https://` (not `http://`)

### If test returns error:
- Check API key is same as in Vercel environment
- Check URL is correct
- Check Bearer word is spelled correctly

---

## Timeline

| Step | Time |
|------|------|
| Get API Key | 1 min |
| Deploy | 2 min |
| Add Key to Vercel | 2 min |
| Wait for Redeploy | 3 min |
| Test | 1 min |
| Submit | 1 min |
| **TOTAL** | **~10 minutes** |

---

## Your Final Submission Info

After completing all steps, you have:

✅ **Endpoint:** https://YOUR_URL/api/detect
✅ **API Key:** YOUR_API_KEY  
✅ **Method:** POST
✅ **Auth:** Bearer token

Submit these to the evaluation system and you are DONE!

---

## That's It!

You don't need to do anything else. Everything is ready.

Just follow the 5 simple steps above.

🎉 **GOOD LUCK!**
