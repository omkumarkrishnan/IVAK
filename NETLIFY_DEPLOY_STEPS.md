# Deploy to Netlify - Step by Step

Follow these exact steps to deploy your Sikkim INSPIRES IVA app to Netlify and make it accessible 24/7.

## Step 1: Create Netlify Account

1. Go to [https://netlify.com](https://netlify.com)
2. Click "Sign up"
3. Choose "Sign up with GitHub" (easiest) or use email

## Step 2: Deploy Your Site

### Option A: Deploy from Git (Recommended - Auto-updates on every push)

1. After logging in, click **"Add new site"** button
2. Select **"Import an existing project"**
3. Choose **"Deploy with GitHub"** (or your Git provider)
4. Authorize Netlify to access your repositories
5. Select your repository: `sikkiminspireiva`
6. Netlify will auto-detect settings from `netlify.toml`

### Build Settings (Verify these are correct)
- **Build command**: `npm run build`
- **Publish directory**: `dist`
- **Base directory**: (leave empty)

These should be automatically detected!

## Step 3: Add Environment Variables

This is CRITICAL - your app won't work without these!

1. Before clicking "Deploy", scroll down to **"Environment variables"**
2. Click **"Add environment variables"** or **"New variable"**

**Add these EXACT values:**

**Variable 1:**
```
Key: VITE_SUPABASE_URL
Value: https://fhxcdsynzagvmdylnihr.supabase.co
```

**Variable 2:**
```
Key: VITE_SUPABASE_ANON_KEY
Value: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZoeGNkc3luemFndm1keWxuaWhyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU2OTAxNDgsImV4cCI6MjA4MTI2NjE0OH0._hEnsxHz34JLzdJORZgdM0FLlS2NYqnxY4tmRu2kno4
```

**Important:** Copy-paste these EXACTLY as shown. No extra spaces or quotes!

## Step 4: Deploy!

1. Click **"Deploy [your-site-name]"** button
2. Wait 2-3 minutes while Netlify builds your app
3. You'll see a build log - it should complete successfully

## Step 5: Access Your Live Site

Once deployment completes:

1. You'll see a URL like: `https://random-name-123456.netlify.app`
2. Click on it to open your live site
3. Test login with your admin credentials

## Step 6: Customize Your URL (Optional)

1. Go to **Site settings** → **Domain management**
2. Click **"Options"** next to your Netlify domain
3. Click **"Edit site name"**
4. Change to something like: `sikkiminspires-iva`
5. Your URL becomes: `https://sikkiminspires-iva.netlify.app`

## What Happens Next?

### Automatic Deployments
- Every time you push code to GitHub, Netlify automatically rebuilds and deploys
- Zero downtime during updates
- Takes about 2-3 minutes per deployment

### Your App is Now:
- Accessible 24/7 from anywhere
- Fast worldwide (Global CDN)
- Secure (HTTPS/SSL automatic)
- Automatically backed up
- Protected from DDoS attacks

## Troubleshooting

### Build Fails?
Check the build log in Netlify dashboard. Common issues:
- Missing environment variables (re-check Step 3)
- Node version (Netlify uses Node 18+ by default, which is correct)

### Site loads but shows errors?
- Verify environment variables are set correctly (no typos)
- Check browser console for error messages
- Verify Supabase is accessible

### 404 Errors on page refresh?
- This is already handled by `netlify.toml` redirects
- If still happening, verify `netlify.toml` is in root directory

## Monitor Your Site

1. Go to Netlify dashboard
2. Click on your site
3. You'll see:
   - **Deploy log**: Build history
   - **Analytics**: Visitor stats (may require upgrade)
   - **Functions**: Edge functions (if you add them)
   - **Deploys**: All deployments with rollback option

## Share Your Site

Your live URL: `https://your-site-name.netlify.app`

Share this with:
- Admins
- Consultants
- Clients
- Field Agents
- IVA personnel

They can access it from any device, anywhere, anytime!

## Cost

**Free forever** for your use case:
- 100GB bandwidth/month
- Unlimited deployments
- Automatic SSL
- No credit card required

## Custom Domain (Optional)

Want to use `inspires.sikkim.gov.in`?

1. Go to **Site settings** → **Domain management**
2. Click **"Add custom domain"**
3. Enter your domain
4. Follow DNS configuration steps
5. SSL certificate automatically provisioned

## Rollback (If Something Goes Wrong)

1. Go to **Deploys** tab
2. Find previous working deployment
3. Click **"Publish deploy"**
4. Site instantly rolls back

## Support

- Documentation: [docs.netlify.com](https://docs.netlify.com)
- Community: [answers.netlify.com](https://answers.netlify.com)
- Status: [netlifystatus.com](https://netlifystatus.com)

---

## Quick Summary

1. Sign up at netlify.com
2. Import your Git repository
3. Add 2 environment variables
4. Click Deploy
5. Wait 2-3 minutes
6. Your app is LIVE!

**Time Required**: 5-10 minutes
**Cost**: $0 (Free forever)
**Uptime**: 99.9%+

Your Sikkim INSPIRES IVA app will be accessible 24/7 from anywhere in the world!
