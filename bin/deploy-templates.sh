#!/usr/bin/env bash

set -e
set -o pipefail

ROOT_PATH="$(dirname "$0")/.."
PROJECT_NAME="${1:-moebius}"
STACK_NAME="${PROJECT_NAME}-aws-cf-templates"

echo "Deploying reusable AWS CloudFront templates…"

aws cloudformation deploy \
  --template-file "${ROOT_PATH}/provision/resources.template" \
  --stack-name "${STACK_NAME}"

echo "Syncing the templates…"

aws s3 sync "${ROOT_PATH}/templates" "s3://${STACK_NAME}"
