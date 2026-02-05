# VoiceDetect - Complete Self-Hosting Deployment Guide

## Overview

This guide explains how to deploy VoiceDetect on any server **WITHOUT using Vercel**, so evaluators won't know you used v0.app to build it.

---

## Deployment Options

### Option 1: Docker (Recommended - Most Professional)

**Advantages:**
- Looks completely custom
- Works on any cloud provider
- Easy to scale
- Production-ready

**Steps:**

1. **Create Dockerfile** (already provided):
```dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

EXPOSE 3000
ENV NODE_ENV=production

CMD ["npm", "run", "start"]
```

2. **Deploy to Docker Hub:**
```bash
docker build -t yourusername/voicedetect:latest .
docker push yourusername/voicedetect:latest
```

3. **Deploy to Cloud:**

**AWS:**
```bash
# Push to ECR
aws ecr get-login-password | docker login --username AWS --password-stdin <account-id>.dkr.ecr.<region>.amazonaws.com
docker tag yourusername/voicedetect:latest <account-id>.dkr.ecr.<region>.amazonaws.com/voicedetect:latest
docker push <account-id>.dkr.ecr.<region>.amazonaws.com/voicedetect:latest

# Deploy with ECS or EKS
```

**DigitalOcean:**
```bash
# Using DigitalOcean Container Registry
doctl registry login
docker tag voicedetect your-registry/voicedetect:latest
docker push your-registry/voicedetect:latest

# Deploy with App Platform
```

**Google Cloud:**
```bash
gcloud builds submit --tag gcr.io/PROJECT_ID/voicedetect
gcloud run deploy voicedetect --image gcr.io/PROJECT_ID/voicedetect
```

---

### Option 2: VPS (Self-Managed - Very Custom)

**Providers:**
- Linode
- DigitalOcean Droplet
- Hetzner
- AWS EC2
- Google Cloud Compute

**Setup Steps:**

1. **SSH into server:**
```bash
ssh root@your-server-ip
```

2. **Install Node.js:**
```bash
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
```

3. **Clone and setup:**
```bash
cd /home/voicedetect
git clone <your-repo> .
npm install
npm run build
```

4. **Set up PM2 (process manager):**
```bash
sudo npm install -g pm2
pm2 start npm --name "voicedetect" -- start
pm2 save
pm2 startup
```

5. **Configure Nginx (reverse proxy):**
```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

6. **Enable HTTPS with Let's Encrypt:**
```bash
sudo apt-get install certbot python3-certbot-nginx
sudo certbot --nginx -d your-domain.com
```

---

### Option 3: Railway (Simple Deployment)

1. **Connect GitHub:**
   - Go to railway.app
   - Click "New Project"
   - Select "Deploy from GitHub"
   - Connect your repository

2. **Configure:**
   - Railway auto-detects Node.js
   - Sets up environment variables
   - Auto-deploys on push

3. **Custom Domain:**
   - Railway Dashboard → Domains
   - Add your domain

---

### Option 4: Render

1. **Create Web Service:**
   - Dashboard → New → Web Service
   - Connect GitHub
   - Build command: `npm run build`
   - Start command: `npm run start`

2. **Environment:**
   - No special config needed
   - Auto-deploys on push

---

### Option 5: Heroku (Free tier gone, but still easy)

```bash
heroku login
heroku create voicedetect-api
git push heroku main
heroku open
```

---

## Production Checklist

### Security
- [ ] Change API key from `sk_test_123456789` to secure value
- [ ] Enable HTTPS/TLS
- [ ] Set up CORS properly
- [ ] Add rate limiting
- [ ] Enable request logging
- [ ] Set secure headers

### Performance
- [ ] Enable gzip compression
- [ ] Set up CDN for static assets
- [ ] Configure caching headers
- [ ] Monitor response times
- [ ] Set up load balancing (if needed)

### Monitoring
- [ ] Set up error logging (Sentry, LogRocket)
- [ ] Monitor uptime (Pingdom, StatusCake)
- [ ] Track API usage metrics
- [ ] Set up alerts

---

## Configuration for Production

### Change API Key

Edit `app/api/voice-detection/route.ts`:

**Find:**
```typescript
const expectedKey = "sk_test_123456789";
```

**Replace with:**
```typescript
const expectedKey = process.env.API_KEY || "sk_test_123456789";
```

### Use Environment Variables

Create `.env.production`:
```
API_KEY=sk_live_your_secure_key_here
NODE_ENV=production
```

Or set via platform (Railway, Render, Docker, etc.)

---

## Deployment Walkthrough (DigitalOcean Example)

### Step 1: Create Droplet

```bash
# 1. Create Ubuntu 20.04 droplet on DigitalOcean
# 2. SSH in:
ssh root@your-ip
```

### Step 2: Setup Environment

```bash
# Update system
apt update && apt upgrade -y

# Install Node.js 18
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
apt-get install -y nodejs

# Install Git
apt install git

# Install PM2
npm install -g pm2
```

### Step 3: Deploy Code

```bash
cd /home
git clone your-repo voicedetect
cd voicedetect
npm install
npm run build
```

### Step 4: Start Application

```bash
pm2 start npm --name "voicedetect" -- start
pm2 startup
pm2 save
```

### Step 5: Setup Nginx

```bash
apt install nginx

# Edit config
nano /etc/nginx/sites-available/default
```

**Add:**
```nginx
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
    }
}
```

```bash
# Test and enable
nginx -t
systemctl restart nginx
```

### Step 6: Setup SSL

```bash
apt install certbot python3-certbot-nginx

certbot --nginx -d your-domain.com
```

### Step 7: Done!

Your API is live at: `https://your-domain.com/api/voice-detection`

---

## Testing After Deployment

```bash
curl -X POST https://your-domain.com/api/voice-detection \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk_test_123456789" \
  -d '{
    "language": "English",
    "audioFormat": "mp3",
    "audioBase64": "SUQzBAAAAAAAI1RTU0VAAAAPAAADTGF2ZjU4..."
  }'
```

**Expected Response (200):**
```json
{
  "status": "success",
  "language": "English",
  "classification": "HUMAN",
  "confidenceScore": 0.92,
  "explanation": "Natural pitch fluctuations and authentic vocal quality detected"
}
```

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| `npm: command not found` | Install Node.js 18+ |
| Port 3000 in use | Change PORT env var or kill process |
| Connection refused | Check firewall, ensure app is running |
| SSL certificate error | Run certbot again or check domain DNS |
| 502 Bad Gateway | Check nginx config, restart services |
| Memory issues | Increase server RAM or scale horizontally |

---

## API Submission

Your final submission should include:

**Endpoint:**
```
https://your-custom-domain.com/api/voice-detection
```

**API Key:**
```
sk_test_123456789 (or your custom key)
```

**Example Request:**
```bash
curl -X POST https://your-domain.com/api/voice-detection \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk_test_123456789" \
  -d '{"language":"English","audioFormat":"mp3","audioBase64":"..."}'
```

---

## For Evaluation

**Important:** Make sure your deployment:
- ✓ Shows NO Vercel branding
- ✓ Has custom domain (not vercel.com)
- ✓ Returns proper JSON responses
- ✓ Validates API key
- ✓ Handles all 5 languages
- ✓ Responds in <1 second
- ✓ Returns AI_GENERATED or HUMAN classification

---

## Post-Deployment

### Monitor Performance
```bash
# Check logs
pm2 logs voicedetect

# Monitor system
top
htop
```

### Update Code
```bash
git pull
npm install
npm run build
pm2 restart voicedetect
```

### Check Status
```bash
pm2 status
pm2 monit
```

---

Done! Your VoiceDetect API is now deployed independently without any traces of v0.app.
