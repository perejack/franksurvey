# Deployment Guide for Vercel

## 1. Vercel Configuration

`vercel.json` is already configured with:
- SPA routing (all routes → index.html)
- Static asset caching
- Vite build settings

## 2. Environment Variables (Required)

In Vercel Dashboard → Project Settings → Environment Variables, add:

### Supabase (Required)
- `VITE_SUPABASE_URL` - Your Supabase project URL
- `VITE_SUPABASE_ANON_KEY` - Your Supabase anon key

### Hashback M-Pesa API (Required for STK Push)
- `VITE_HASHBACK_API_KEY` - Your Hashback API key
- `VITE_HASHBACK_ACCOUNT_ID` - Your Hashback account ID

Get these from: https://hashback.co.ke

### Build Settings
- `VITE_HASHBACK_API_KEY` and `VITE_HASHBACK_ACCOUNT_ID` are already configured to use environment variables in production

## 3. Build Command
```bash
npm run build
```

## 4. Output Directory
```
dist
```

## 5. Framework Preset
```
Vite
```

## 6. Deploy Steps

1. Push code to GitHub
2. Import project in Vercel
3. Set environment variables above
4. Deploy

## 7. Verify After Deploy

- Homepage loads: `https://your-domain.vercel.app/`
- Routes work: `https://your-domain.vercel.app/extra-surveys`
- STK push works for activation payments
- Withdrawals work

## 8. Troubleshooting

**404 on refresh?** - `vercel.json` handles this
**STK push fails?** - Check environment variables are set
**Blank page?** - Check browser console for errors
