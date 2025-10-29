#!/bin/bash
set -e

echo "🚀 Initializing Terraform..."
terraform init

echo "📝 Planning infrastructure changes..."
terraform plan -out=tfplan

echo "✅ Applying infrastructure..."
terraform apply -auto-approve tfplan

echo "🌍 Deploying static website to S3..."
aws s3 sync ./site s3://$(terraform output -raw s3_bucket_name) --delete

echo "✨ Deployment complete!"
echo "Check your CloudFront URL:"
terraform output cloudfront_domain
