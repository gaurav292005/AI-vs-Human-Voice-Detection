# How to Generate API Key - Simple Steps

## What is an API Key?
A special secret code that allows users to use your voice detection service safely.

---

## Step 1: Open Terminal/Command Prompt

**Mac/Linux Users:**
- Press: `Command + Space`
- Type: `Terminal`
- Press: `Enter`

**Windows Users:**
- Press: `Windows + R`
- Type: `cmd`
- Press: `Enter`

---

## Step 2: Copy ONE of These Commands

### Command Option A (Mac/Linux)
```bash
openssl rand -hex 32
```

### Command Option B (Any Computer)
```bash
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
```

### Command Option C (Any Computer)
```bash
python3 -c "import secrets; print(secrets.token_hex(32))"
```

---

## Step 3: Paste Command in Terminal

- Right-click in terminal window
- Select "Paste"
- Press `Enter`

---

## Step 4: Copy the Output

You will see something like this:
```
a7f9e8d4c1b2f3e5a6d7e8f9g0h1i2j3k4l5m6n7o8p9q0r1s2t3u4v5w6x7y8z9
```

**This is your API Key!**

- Select all text (Ctrl+A or Cmd+A)
- Copy it (Ctrl+C or Cmd+C)
- Paste it somewhere safe (notepad, text file, etc.)

---

## Step 5: Use Your API Key in 2 Places

### Place 1: Vercel Dashboard (One Time Setup)

1. Go to: https://vercel.com/dashboard
2. Click your project name
3. Click "Settings" tab
4. Click "Environment Variables" 
5. Click "Add New"
6. Name field: `VOICEGUARD_API_KEY`
7. Value field: Paste your API key
8. Click "Save"
9. Click "Redeploy" button

### Place 2: Voice Detection App (Every Time You Use)

1. Open your voice detection app in browser
2. Find the input field that says: "Enter your VOICEGUARD_API_KEY"
3. Paste your API key there
4. Upload audio file
5. Click "Analyze Voice"

---

## Example

**Generated API Key:**
```
f4e9a7c2b1d8f3e5a9c7e2b4d1f8a3c5e7b2d4f6a8c1e3b5d7f9a2c4e6b8d0
```

**In Vercel:**
- Name: VOICEGUARD_API_KEY
- Value: f4e9a7c2b1d8f3e5a9c7e2b4d1f8a3c5e7b2d4f6a8c1e3b5d7f9a2c4e6b8d0

**In App:**
- Paste in the API Key field
- Upload audio
- Click Analyze

---

## Troubleshooting

**Q: Command not working?**
- Make sure you're in Terminal/Command Prompt
- Try a different command option
- Make sure Node.js or Python is installed

**Q: Can't find the API Key input field?**
- Look at the top of the app
- It says "API Key *" with a red asterisk
- Input field shows: "Enter your VOICEGUARD_API_KEY"

**Q: Getting "Invalid API Key" error?**
- Make sure you copied the ENTIRE key (nothing cut off)
- Make sure you set it in Vercel environment variables
- Make sure you redeployed after setting it

---

## Done!

Once you follow these steps, your API key is ready to use. The same key works everywhere.

**Save it somewhere safe - you will use it multiple times!**
