#!/bin/bash

# 1. Create a directory for the project
echo "Creating directory 'nginx-proxy-manager'..."
mkdir -p nginx-proxy-manager
cd nginx-proxy-manager

# 2. Create the docker-compose.yml file
echo "Generating docker-compose.yml configuration..."
cat <<EOF > docker-compose.yml
version: '3.8'
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    restart: unless-stopped
    ports:
      # Public HTTP Port
      - '80:80'
      # Admin Web Port
      - '81:81'
      # Public HTTPS Port
      - '443:443'
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
EOF

# 3. Start the container
echo "Pulling image and starting Nginx Proxy Manager..."
docker compose up -d

# 4. Success Message
echo "-------------------------------------------------------"
echo "Installation Complete!"
echo "Access the Admin UI at: http://<YOUR_SERVER_IP>:81"
echo "Default Email:    admin@example.com"
echo "Default Password: changeme"
echo "-------------------------------------------------------"