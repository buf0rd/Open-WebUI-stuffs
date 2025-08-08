#!/bin/bash

# CONFIGURABLE
CONTAINER_NAME="open-webui"
IMAGE_NAME="ghcr.io/open-webui/open-webui:main"
VOLUME_NAME="open-webui-data"

echo "==> Stopping container: $CONTAINER_NAME"
docker stop "$CONTAINER_NAME" 2>/dev/null || echo "Container not running"

echo "==> Backing up current volume '$VOLUME_NAME' to 'backup_${VOLUME_NAME}_$(date +%Y%m%d%H%M%S).tar.gz'"
docker run --rm -v "$VOLUME_NAME":/data -v "$(pwd)":/backup alpine \
  tar czf /backup/backup_"$VOLUME_NAME"_$(date +%Y%m%d%H%M%S).tar.gz -C /data .

echo "==> Removing container: $CONTAINER_NAME"
docker rm "$CONTAINER_NAME" 2>/dev/null || echo "Container already removed"

echo "==> Pulling latest image: $IMAGE_NAME"
docker pull "$IMAGE_NAME"

echo "==> Starting new container with updated image..."
docker run -d \
  --name "$CONTAINER_NAME" \
  -p 3000:8080 \
  -v "$VOLUME_NAME":/app/backend/data \
  "$IMAGE_NAME"

echo "==> Done. Container '$CONTAINER_NAME' is updated and running."
