#!/usr/bin/env bash

set -euo pipefail

project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
script="$project_root/automation/s3-log-sync.sh"

if "$script" >/dev/null 2>&1; then
  echo "Expected missing arguments to fail." >&2
  exit 1
fi

test_dir="$(mktemp -d)"
trap 'rm -rf "$test_dir"' EXIT

mkdir -p "$test_dir/bin"
args_file="$test_dir/aws-args.txt"

printf '%s\n' \
  '#!/usr/bin/env bash' \
  'printf "%s\n" "$@" > "$FAKE_AWS_ARGS"' \
  > "$test_dir/bin/aws"
chmod +x "$test_dir/bin/aws"

PATH="$test_dir/bin:$PATH" FAKE_AWS_ARGS="$args_file" \
  "$script" "s3://example-audit-bucket/AWSLogs/example/CloudTrail/" "$test_dir/output"

expected_args="$(printf '%s\n' \
  "s3" \
  "sync" \
  "s3://example-audit-bucket/AWSLogs/example/CloudTrail/" \
  "$test_dir/output" \
  "--exclude" \
  "*" \
  "--include" \
  "*.json.gz")"
actual_args="$(<"$args_file")"

if [[ "$actual_args" != "$expected_args" ]]; then
  echo "Unexpected AWS CLI arguments." >&2
  printf 'Actual:\n%s\n' "$actual_args" >&2
  exit 1
fi

echo "s3-log-sync tests passed"
