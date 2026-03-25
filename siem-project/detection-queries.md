# Detection Queries

## Process

- Queried ingested CloudTrail logs in Splunk
- Used `spath` and `mvexpand` to parse nested JSON records
- Built detection queries to identify AWS activity and anomalies

Base query used for parsing:

index=* sourcetype=_json  
| spath path=Records{} output=record  
| mvexpand record  
| spath input=record  

---

## Result

Successfully created detection queries for:

- AWS API activity
- EC2-related actions
- Failed API calls
- Identity-based activity
- Service activity over time

---

## Insight

### Top AWS API Actions

- Most common event: `DescribeAlarms`
- Other frequent events: `DescribeAddresses`, `DescribeSecurityGroups`, `GetBucketLogging`

These actions indicate monitoring and read-based activity within the environment.

---

### EC2 Activity

- Observed events:
  - `DescribeAddresses`
  - `DescribeKeyPairs`
  - `DescribeSecurityGroups`
  - `DescribeRegions`

This confirms visibility into EC2-related AWS activity through Splunk.

---

### Failed API Calls

- Detected failed action:
  - `GetInsightSelectors`
  - Error: `InsightNotEnabledException`

Failed API calls highlight configuration issues or attempted actions against unavailable features.

---

### Identity-Based Activity

- Majority of activity from:
  - Root account ARN

- Additional activity from:
  - AWS service role (Resource Explorer)

This demonstrates attribution of AWS activity to identities and services.

---

### Activity Over Time

- Observed activity across:
  - EC2
  - CloudTrail
  - Monitoring
  - S3
  - Notifications

This provides visibility into service-level activity trends.

---

## Security Insight

Splunk enables centralized analysis of AWS API activity, allowing identification of patterns, failed actions, and service usage across the environment.

CloudTrail provides strong visibility into AWS infrastructure activity but does not capture OS-level events such as SSH access or port scanning.
