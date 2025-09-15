# n8n Render Deployment

This project deploys n8n (Community Edition) to Render cloud platform.

## Features
- Free n8n Community Edition
- Persistent data storage
- Automatic HTTPS
- Custom domain support

## Deployment Instructions

### Method 1: Using render.yaml (Recommended)

1. **Sign up for Render**: Go to [render.com](https://render.com) and create a free account
2. **Connect your repository**: Link your GitHub account and select this repository
3. **Deploy**: Render will automatically detect the `render.yaml` file and configure everything
4. **Wait for deployment**: The initial deployment takes 5-10 minutes
5. **Access your n8n instance**: Visit the provided URL (e.g., `https://your-app-name.onrender.com`)

### Method 2: Manual Setup

1. **Sign up for Render**: Go to [render.com](https://render.com)
2. **Create a new Web Service**:
   - Connect your GitHub repository
   - Select "Docker" as the environment
   - Set the Dockerfile path to `./Dockerfile`
3. **Configure the service**:
   - **Region**: Oregon (or your preferred region)
   - **Plan**: Free (or upgrade for better performance)
   - **Port**: 10000
4. **Add persistent storage**:
   - Name: `n8n-data`
   - Mount Path: `/home/n8nuser/.n8n`
   - Size: 1GB (free tier)
5. **Configure environment variables** (see section below)
6. **Deploy**: Click "Create Web Service"

### Important Notes

- ⚠️ **Free tier limitations**: The service will spin down after 15 minutes of inactivity
- 🔒 **Security**: Add basic authentication for production use
- 💾 **Data persistence**: Workflows and data are saved to the persistent disk
- 🌐 **Custom domain**: Available with paid plans

## Environment Variables

### Required Variables (automatically set by render.yaml):

- `N8N_HOST`: 0.0.0.0
- `N8N_PORT`: 10000
- `N8N_PROTOCOL`: https
- `NODE_ENV`: production
- `GENERIC_TIMEZONE`: UTC
- `WEBHOOK_URL`: https://your-app-name.onrender.com
- `N8N_ENCRYPTION_KEY`: Auto-generated secure key
- `N8N_DISABLE_PRODUCTION_MAIN_PROCESS`: true (for free tier)
- `EXECUTIONS_PROCESS`: main

### Optional Variables (add if needed):

**Authentication** (recommended for production):
```
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=your_secure_password
```

**Database** (for better performance, requires paid plan):
```
DB_TYPE=postgresdb
DB_POSTGRESDB_HOST=your_postgres_host
DB_POSTGRESDB_PORT=5432
DB_POSTGRESDB_DATABASE=n8n
DB_POSTGRESDB_USER=your_user
DB_POSTGRESDB_PASSWORD=your_password
```

## Local Development

```bash
npm install
npm start
```

Access n8n at http://localhost:5678

## Post-Deployment Setup

1. **First Access**: Visit your Render URL (e.g., `https://your-app-name.onrender.com`)
2. **Create Admin User**: Set up your first user account
3. **Configure Webhooks**: Update webhook URLs in your workflows to use your Render domain
4. **Test Workflows**: Verify that your automations work correctly

## Troubleshooting

### Common Issues:

1. **Service won't start**: Check the deployment logs in Render dashboard
2. **Database connection issues**: Verify environment variables
3. **Webhook failures**: Ensure webhook URLs use your Render domain
4. **Performance issues**: Consider upgrading to a paid plan for better resources

### Monitoring:

- **Logs**: Available in the Render dashboard
- **Metrics**: CPU, memory, and request metrics in Render dashboard
- **Health checks**: Render automatically monitors service health

## File Structure

```
n8n-render-project/
├── Dockerfile              # Docker configuration
├── package.json            # Node.js dependencies
├── render.yaml             # Render deployment configuration
├── .env.example           # Environment variables template
└── README.md              # This file
```