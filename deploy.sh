#!/bin/bash

# Deploy n8n to Render - Deployment Helper Script
# This script helps prepare and deploy your n8n instance to Render

echo "🚀 n8n Render Deployment Helper"
echo "================================"

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "❌ Git repository not initialized. Run 'git init' first."
    exit 1
fi

# Check if all required files exist
required_files=("package.json" "Dockerfile" "render.yaml" ".gitignore")
for file in "${required_files[@]}"; do
    if [ ! -f "$file" ]; then
        echo "❌ Required file missing: $file"
        exit 1
    fi
done

echo "✅ All required files present"

# Add all files to git
echo "📁 Adding files to git..."
git add .

# Check git status
echo "📊 Git status:"
git status --short

# Commit if there are changes
if ! git diff --cached --quiet; then
    echo "💾 Committing changes..."
    git commit -m "Deploy n8n to Render - $(date '+%Y-%m-%d %H:%M:%S')"
else
    echo "ℹ️  No changes to commit"
fi

echo ""
echo "🎯 Next Steps:"
echo "1. Push to GitHub:"
echo "   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git"
echo "   git branch -M main"
echo "   git push -u origin main"
echo ""
echo "2. Deploy on Render:"
echo "   - Go to https://render.com"
echo "   - Click 'New' → 'Web Service'"
echo "   - Connect your GitHub repository"
echo "   - Render will auto-detect render.yaml"
echo "   - Click 'Deploy'"
echo ""
echo "3. Your n8n will be available at:"
echo "   https://YOUR-APP-NAME.onrender.com"
echo ""
echo "🎉 Happy automating!"