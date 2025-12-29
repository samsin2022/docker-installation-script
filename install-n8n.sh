#!/bin/bash

echo "------------------------------------------"
echo "   n8n Docker Installer (IP Access Version)"
echo "------------------------------------------"
read -p "Enter your Server IP (e.g., 54.255.250.112): " SERVER_IP

if [ -z "$SERVER_IP" ]; then
    echo "❌ Error: IP address cannot be empty."
    exit 1
fi

# 1. Create project directory and fix permissions
mkdir -p n8n-docker/n8n-data
sudo chown -R 1000:1000 n8n-docker/n8n-data
cd n8n-docker

# 2. Create the docker-compose file
cat <<EOF > docker-compose.yml
version: "3"
services:
  n8n:
    image: docker.n8n.io/n8nio/n8n
    restart: always
    ports:
      - "5678:5678"
    environment:
      - N8N_HOST=${SERVER_IP}
      - N8N_PORT=5678
      - N8N_PROTOCOL=http
      - NODE_ENV=production
      - WEBHOOK_URL=http://${SERVER_IP}:5678/
      - N8N_SECURE_COOKIE=false
    volumes:
      - ./n8n-data:/home/node/.n8n
EOF

# 3. Start the container
echo "📦 Starting n8n..."
docker compose up -d

echo "✅ Success! Access at http://${SERVER_IP}:5678"