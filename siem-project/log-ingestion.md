
# Log Ingestion

## Process

- Created an S3 bucket for CloudTrail logs
- Configured CloudTrail to send logs to S3
- Downloaded CloudTrail JSON logs
- Uploaded logs into Splunk using the "Add Data" feature

## Result

Successfully ingested AWS logs into Splunk for analysis.

## Insight

Centralized logging is critical for visibility and detection in cloud environments.

CloudTrail logs were initially ingested as JSON objects containing a top-level Records array, causing each file to appear as a single Splunk event. To analyze individual AWS actions, the data was unpacked in Splunk using spath and mvexpand, which expanded the array into individual log records for detection queries.
