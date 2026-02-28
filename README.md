# Kali Linux GUI on Railway

Deploy Kali Linux with a full XFCE desktop accessible from your browser via noVNC.

## How to Deploy

### 1. Push to GitHub
```bash
git init
git add .
git commit -m "Kali Linux GUI on Railway"
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git push -u origin main
```

### 2. Deploy on Railway
1. Go to [railway.app](https://railway.app) and sign in
2. Click **"New Project"** → **"Deploy from GitHub Repo"**
3. Select your repository
4. Railway will auto-detect the Dockerfile and build it
5. Once deployed, click **"Generate Domain"** in the Settings tab to get a public URL

### 3. Access the Desktop
- Open the generated Railway URL in your browser
- Click **"Connect"** on the noVNC page
- **VNC Password:** `kali`
- You'll see the full Kali Linux XFCE desktop in your browser

## Credentials
| Field    | Value |
|----------|-------|
| Username | kali  |
| Password | kali  |
| VNC Pass | kali  |

## Notes
- The desktop resolution is **1920×1080** (configurable in `start.sh`)
- Build time is ~10-15 minutes (Kali desktop packages are large)
- Railway free tier has resource limits; consider a paid plan for better performance
- To install more Kali tools, add them to the `apt-get install` line in the Dockerfile
