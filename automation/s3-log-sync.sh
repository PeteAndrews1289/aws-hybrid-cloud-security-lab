#!/usr/bin/env bash

set -euo pipefail

usage() {
  echo "Usage: $0 s3://BUCKET/PREFIX [DESTINATION]" >&2
}

if [[ $# -lt 1 || $# -gt 2 ]]; then
  usage
  exit 64
fi

if ! command -v aws >/dev/null 2>&1; then
  echo "Error: the AWS CLI is required." >&2
  exit 69
fi

source_uri="$1"
destination="${2:-./cloudtrail-logs}"

if [[ "$source_uri" != s3://* ]]; then
  echo "Error: source must be an s3:// URI." >&2
  exit 64
fi

mkdir -p -- "$destination"

aws s3 sync "$source_uri" "$destination" \
  --exclude "*" \
  --include "*.json.gz"

echo "CloudTrail logs synced to $destination"
