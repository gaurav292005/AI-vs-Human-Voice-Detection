# HOW TO GENERATE API KEY - STEP BY STEP GUIDE

## FOR WINDOWS, MAC, AND LINUX

---

## WHAT IS AN API KEY?

An API Key is a secret password that protects your voice detection API.
- It's unique to you
- It's random
- It's secure
- You generate it yourself

---

## METHOD 1: WINDOWS USERS

### Step 1: Open Terminal
- Press: `Windows Key + R`
- Type: `cmd`
- Press: `Enter`
- A black window opens

### Step 2: Copy & Paste This Command
```
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
```

### Step 3: Press Enter
- Wait 1 second
- You see a long random text

### Step 4: Copy the Key
- Right-click the long text
- Click "Copy"
- Now you have your API Key

### Step 5: Save It
- Open Notepad
- Paste the key
- Save as "API_KEY.txt"

---

## METHOD 2: MAC USERS

### Step 1: Open Terminal
- Press: `Command + Space`
- Type: `terminal`
- Press: `Enter`
- A white window opens

### Step 2: Copy & Paste This Command
```
openssl rand -hex 32
```

### Step 3: Press Enter
- Wait 1 second
- You see a long random text

### Step 4: Copy the Key
- Select all the text
- Press: `Command + C`
- Now you have your API Key

### Step 5: Save It
- Open Notes app
- Paste the key
- Save it

---

## METHOD 3: LINUX USERS

### Step 1: Open Terminal
- Press: `Ctrl + Alt + T`
- A terminal window opens

### Step 2: Copy & Paste This Command
```
openssl rand -hex 32
```

### Step 3: Press Enter
- Wait 1 second
- You see a long random text

### Step 4: Copy the Key
- Select all the text
- Press: `Ctrl + C`
- Now you have your API Key

### Step 5: Save It
- Use any text editor
- Paste the key
- Save it

---

## EXAMPLE API KEY OUTPUT

When you run the command, you get something like this:

```
f4e9a7c2b1d8f3e5a9c7e2b4d1f8a3c5e7b2d4f6a8c1e3b5d7f9a2c4e6b8d0
```

This is your unique API Key.

---

## WHAT YOUR API KEY LOOKS LIKE

- Length: Long random text (64 characters)
- Characters: Letters (a-f) and Numbers (0-9)
- Example: `a7f9e8d4c1b2f3e5a6d7e8f9g0h1i2j3k4l5m6n7o8p9q0r1s2t3u4v5w6x`

---

## KEEP YOUR API KEY SECRET

✓ Save it in a safe place
✓ Never share it with anyone
✓ Never post it on internet
✓ Never commit it to GitHub
✓ Store in Vercel securely

---

## NEXT: WHERE TO USE YOUR API KEY

### In Vercel (Your Server)
1. Go to vercel.com/dashboard
2. Click your project
3. Go to Settings
4. Find "Environment Variables"
5. Click "Add New"
6. Name: `VOICEGUARD_API_KEY`
7. Value: Paste your key
8. Click Save
9. Redeploy

### In Your App (When Using)
1. Open your voice detection app
2. Find the "API Key" input field
3. Paste your key
4. Upload audio file
5. Click "Analyze Voice"
6. Done!

---

## TROUBLESHOOTING

### Problem: "Command not found"
**Solution:** 
- Windows: Make sure you installed Node.js
- Mac/Linux: Try `which openssl` to check if installed

### Problem: I lost my API Key
**Solution:**
- Generate a new one
- Follow the steps again
- Update Vercel environment variables

### Problem: My key doesn't work
**Solution:**
- Check if it's pasted completely (no spaces)
- Check if it's in Vercel environment variables
- Redeploy the project
- Try again

---

## SECURITY TIPS

1. Generate a new key each time you need to reset
2. Never share your API key in emails or messages
3. Never put your key in code files
4. Always use Vercel environment variables
5. If someone sees your key, generate a new one

---

## QUICK REFERENCE

| Task | Command |
|------|---------|
| Windows | `node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"` |
| Mac | `openssl rand -hex 32` |
| Linux | `openssl rand -hex 32` |

---

## SUMMARY

1. Open Terminal on your computer
2. Paste the command for your OS
3. Press Enter
4. Copy the random text (your API Key)
5. Save it somewhere safe
6. Add it to Vercel environment variables
7. Use it in your app

**That's it! You have your API Key!**

---

## NEED HELP?

Read: `HOW_TO_GENERATE_API_KEY.md` for more details
Read: `SIMPLE_SUBMISSION.md` for full submission guide
