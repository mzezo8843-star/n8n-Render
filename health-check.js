#!/usr/bin/env node

/**
 * Health check script for n8n on Render
 * This script verifies that n8n is running and responding
 */

const http = require('http');

const options = {
  hostname: process.env.N8N_HOST || '0.0.0.0',
  port: process.env.N8N_PORT || 10000,
  path: '/healthz',
  method: 'GET',
  timeout: 5000
};

const req = http.request(options, (res) => {
  if (res.statusCode === 200) {
    console.log('✅ n8n service is healthy');
    process.exit(0);
  } else {
    console.log(`❌ n8n service returned status: ${res.statusCode}`);
    process.exit(1);
  }
});

req.on('error', (err) => {
  console.log(`❌ Health check failed: ${err.message}`);
  process.exit(1);
});

req.on('timeout', () => {
  console.log('❌ Health check timeout');
  req.destroy();
  process.exit(1);
});

req.setTimeout(5000);
req.end();