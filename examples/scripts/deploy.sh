#!/bin/bash

set -e

echo "🚀 Deploying application..."

VERSION=$(git describe --tags --always)
REGISTRY="myregistry.azurecr.io"
IMAGE="$REGISTRY/myapp:$VERSION"

docker build -t "$IMAGE" .
docker push "$IMAGE"

kubectl set image deployment/app app="$IMAGE" --record

kubectl rollout status deployment/app

echo "✅ Deployment complete: $VERSION"
