FROM node:18-alpine

# Create app directory
WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Install n8n globally
RUN npm install -g n8n@latest

# Create n8n user
RUN adduser -D -s /bin/sh n8nuser

# Create data directory
RUN mkdir -p /home/n8nuser/.n8n && chown -R n8nuser:n8nuser /home/n8nuser

# Switch to n8n user
USER n8nuser

# Set working directory to n8n user home
WORKDIR /home/n8nuser

# Expose port
EXPOSE 10000

# Set environment variables
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=10000
ENV N8N_PROTOCOL=https
ENV NODE_ENV=production
ENV WEBHOOK_URL=https://your-app-name.onrender.com

# Start n8n
CMD ["n8n", "start"]