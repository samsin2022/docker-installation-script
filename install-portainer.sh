#!/bin/bash

# Exit on error
set -e

echo "Creating Portainer Data Volume"
docker volume create portainer_data

echo "Deploying Portainer Server..."
docker run -d \
  -p 8000:8000 \
  -p 9443:9443 \
  --name portainer \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce:latest

echo "Portainer installation successful!"
echo "You can access the UI at: https://localhost:9443 or https://<your-server-ip>:9443"