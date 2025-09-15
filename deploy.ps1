# Deploy n8n to Render - PowerShell Deployment Helper Script
# This script helps prepare and deploy your n8n instance to Render

Write-Host "🚀 n8n Render Deployment Helper" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green

# Check if git is initialized
if (-not (Test-Path ".git")) {
    Write-Host "❌ Git repository not initialized. Run 'git init' first." -ForegroundColor Red
    exit 1
}

# Check if all required files exist
$requiredFiles = @("package.json", "Dockerfile", "render.yaml", ".gitignore")
foreach ($file in $requiredFiles) {
    if (-not (Test-Path $file)) {
        Write-Host "❌ Required file missing: $file" -ForegroundColor Red
        exit 1
    }
}

Write-Host "✅ All required files present" -ForegroundColor Green

# Add all files to git
Write-Host "📁 Adding files to git..." -ForegroundColor Yellow
git add .

# Check git status
Write-Host "📊 Git status:" -ForegroundColor Yellow
git status --short

# Commit if there are changes
$gitDiff = git diff --cached --quiet
if ($LASTEXITCODE -ne 0) {
    Write-Host "💾 Committing changes..." -ForegroundColor Yellow
    $commitMessage = "Deploy n8n to Render - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    git commit -m $commitMessage
} else {
    Write-Host "ℹ️  No changes to commit" -ForegroundColor Blue
}

Write-Host ""
Write-Host "🎯 Next Steps:" -ForegroundColor Cyan
Write-Host "1. Push to GitHub:" -ForegroundColor White
Write-Host "   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git" -ForegroundColor Gray
Write-Host "   git branch -M main" -ForegroundColor Gray
Write-Host "   git push -u origin main" -ForegroundColor Gray
Write-Host ""
Write-Host "2. Deploy on Render:" -ForegroundColor White
Write-Host "   - Go to https://render.com" -ForegroundColor Gray
Write-Host "   - Click 'New' → 'Web Service'" -ForegroundColor Gray
Write-Host "   - Connect your GitHub repository" -ForegroundColor Gray
Write-Host "   - Render will auto-detect render.yaml" -ForegroundColor Gray
Write-Host "   - Click 'Deploy'" -ForegroundColor Gray
Write-Host ""
Write-Host "3. Your n8n will be available at:" -ForegroundColor White
Write-Host "   https://YOUR-APP-NAME.onrender.com" -ForegroundColor Gray
Write-Host ""
Write-Host "🎉 Happy automating!" -ForegroundColor Green