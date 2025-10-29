#!/bin/bash
set -e

BUCKET_NAME=$(terraform output -raw s3_bucket_name)

echo "⚠️ Emptying S3 bucket before destroy: $BUCKET_NAME..."
aws s3 rm s3://$BUCKET_NAME --recursive || true

echo "💥 Destroying infrastructure..."
terraform destroy -auto-approve

echo "✅ All resources destroyed successfully!"