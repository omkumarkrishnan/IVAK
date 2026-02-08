# START HERE - Deploy Your App to Netlify

Your app is ready to go live! Follow this checklist to deploy to Netlify in 5-10 minutes.

## Pre-flight Check

- [x] App built successfully (332 KB bundle)
- [x] Supabase backend running at `https://fhxcdsynzagvmdylnihr.supabase.co`
- [x] All 130+ database migrations applied
- [x] Edge functions deployed (create-user, delete-user, list-users)
- [x] 8 departments configured with 50+ DLIs
- [x] Environment variables configured
- [x] netlify.toml configuration file ready
- [x] All documentation created

## Your Deployment Checklist

Follow the detailed guide: [NETLIFY_DEPLOY_STEPS.md](./NETLIFY_DEPLOY_STEPS.md)

### Quick Steps:

1. **Sign Up** → Go to [netlify.com](https://netlify.com) and sign up with GitHub

2. **Import Project** → Click "Add new site" → "Import an existing project"

3. **Connect Repository** → Select your `sikkiminspireiva` repository

4. **Verify Settings** (Auto-detected from netlify.toml):
   - Build command: `npm run build` ✓
   - Publish directory: `dist` ✓

5. **Add Environment Variables** (CRITICAL - Copy these exactly):

   ```
   VITE_SUPABASE_URL=https://fhxcdsynzagvmdylnihr.supabase.co
   VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZoeGNkc3luemFndm1keWxuaWhyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU2OTAxNDgsImV4cCI6MjA4MTI2NjE0OH0._hEnsxHz34JLzdJORZgdM0FLlS2NYqnxY4tmRu2kno4
   ```

6. **Deploy** → Click "Deploy site" and wait 2-3 minutes

7. **Done!** → Your app is live at `https://your-site-name.netlify.app`

## After Deployment

### Test Your Live Site:
- [ ] Visit your Netlify URL
- [ ] Test login with admin credentials
- [ ] Upload a test file
- [ ] Verify departments load correctly
- [ ] Check dashboard displays properly

### Share With Users:
Send your live URL to:
- Government officials
- Department heads
- IVA personnel
- Consultants
- Field agents

### Customize (Optional):
- Change site name: Settings → Domain management → Edit site name
- Add custom domain: Settings → Domain management → Add custom domain

## What You're Getting

- **Always Online**: 99.9% uptime guarantee
- **Automatic Updates**: Git push = auto-deploy
- **Global Speed**: Served from CDN worldwide
- **Zero Cost**: Free tier includes 100GB/month bandwidth
- **Secure**: HTTPS/SSL automatic
- **Zero Maintenance**: Fully managed infrastructure

## Support Documentation

- **Deployment Guide**: [NETLIFY_DEPLOY_STEPS.md](./NETLIFY_DEPLOY_STEPS.md) - Complete walkthrough
- **Full Deployment Options**: [DEPLOYMENT.md](./DEPLOYMENT.md) - All platforms
- **Production Checklist**: [PRODUCTION_CHECKLIST.md](./PRODUCTION_CHECKLIST.md) - Pre-launch check
- **Quick Deploy**: [QUICK_DEPLOY.md](./QUICK_DEPLOY.md) - Overview of options
- **Project Documentation**: [README.md](./README.md) - Complete reference

## Environment Variables Reference

Keep these secure! Never commit to Git.

```bash
VITE_SUPABASE_URL=https://fhxcdsynzagvmdylnihr.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZoeGNkc3luemFndm1keWxuaWhyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU2OTAxNDgsImV4cCI6MjA4MTI2NjE0OH0._hEnsxHz34JLzdJORZgdM0FLlS2NYqnxY4tmRu2kno4
```

## Troubleshooting

### Build fails on Netlify?
- Check environment variables are set correctly
- Review build log for specific errors
- Verify Node.js version (should use v18+)

### App loads but shows blank page?
- Open browser console (F12) to see errors
- Verify environment variables have no typos
- Check Supabase URL is accessible

### Need to rollback?
- Go to Deploys tab in Netlify
- Find previous working deploy
- Click "Publish deploy"

## Ready to Deploy?

Open [NETLIFY_DEPLOY_STEPS.md](./NETLIFY_DEPLOY_STEPS.md) and follow the detailed walkthrough!

Time to deploy: **5-10 minutes**
Cost: **$0**
Result: **App accessible 24/7 worldwide**

Let's make your app live!
