# Log Ingestion

## Process

- Retrieved AWS CloudTrail logs from an S3 bucket
- Navigated to the CloudTrail log path for a specific date
- Downloaded `.json.gz` log files locally
- Extracted logs into JSON format using macOS terminal
- Uploaded logs into Splunk Enterprise using the "Add Data" feature
- Configured source type as `_json` during ingestion

## Result

Successfully ingested AWS CloudTrail logs into Splunk Enterprise for analysis.

## Insight

CloudTrail logs were initially ingested as JSON objects containing a top-level `Records` array, causing each file to appear as a single Splunk event.

To analyze individual AWS actions, the data was unpacked in Splunk using `spath` and `mvexpand`, which expanded the array into individual log records for detection queries.

This demonstrated the importance of understanding log structure when integrating data into a SIEM.

## Architecture

AWS CloudTrail → S3 → Splunk Enterprise (local ingestion)
