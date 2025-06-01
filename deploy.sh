#!/usr/bin/env bash

cfn-lint -t infrastructure/template.yaml
sam validate -t infrastructure/template.yaml --region eu-west-2
sam validate -t infrastructure/template.yaml --lint
sam build -t infrastructure/template.yaml --parallel

sam deploy \
  --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" \
  --no-fail-on-empty-changeset \
  --no-disable-rollback \
  --no-confirm-changeset \
  --resolve-s3 \
  --template infrastructure/template.yaml \
  --stack-name wc-infrastructure \
  --region eu-west-2 \
  --profile pokerpoint