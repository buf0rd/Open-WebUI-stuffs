#!/bin/bash

# CONFIGURABLE
CONTAINER_NAME="open-webui"
IMAGE_NAME="ghcr.io/open-webui/open-webui:main"

echo "==> Stopping container: $CONTAINER_NAME"
docker stop "$CONTAINER_NAME"

echo "==> Removing container: $CONTAINER_NAME"
docker rm "$CONTAINER_NAME"

echo "==> Pulling latest image: $IMAGE_NAME"
docker pull "$IMAGE_NAME"

echo "==> Starting new container with updated image..."
docker run -d \
  --name "$CONTAINER_NAME" \
  -p 3000:8080 \
  -v open-webui-data:/app/backend/data \
  "$IMAGE_NAME"

echo "==> Done. Done. Done son! Container '$CONTAINER_NAME' is updated and running."
