#!/bin/bash

source ".deploy/variables.sh"
source ".deploy/base.sh"

IMAGE_NAME="bookstore"

deploy \
  --region "$REGION" \
  --aws-access-key "$AWS_ACCESS_KEY_ID" \
  --aws-secret-key "$AWS_SECRET_ACCESS_KEY" \
  --image-name "$IMAGE_NAME" \
  --repo "$ECR_ID.dkr.ecr.$REGION.amazonaws.com/$IMAGE_NAME" \
  --cluster "bookstore-cluster" \
  --service "bookstore" \
  --running-tag "latest" \
  --docker_file "./Dockerfile"