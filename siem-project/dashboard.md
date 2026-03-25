# Dashboard

## Process

- Created a Splunk dashboard to visualize AWS CloudTrail activity
- Added multiple panels to represent different security use cases
- Used SPL queries to parse and analyze CloudTrail logs
- Applied `spath` and `mvexpand` to extract individual records from nested JSON data
- Configured visualizations including bar charts and time-based graphs

## Panels

- Top AWS API Actions
- EC2 Activity
- Failed API Calls
- AWS Activity Over Time

## Result

Successfully built a functional SIEM dashboard that provides visibility into AWS API activity, service usage, and potential error events.

## Insight

The dashboard highlights that most activity in the environment consists of read-based AWS API calls such as `Describe*` operations, which are commonly used for monitoring and enumeration.

EC2-related activity was successfully isolated, demonstrating visibility into infrastructure-level actions.

A failed API call (`InsightNotEnabledException`) was detected, showing that Splunk can identify misconfigurations and abnormal API behavior.

The time-based visualization provides insight into when AWS services are active, enabling detection of unusual spikes or patterns.

## Security Insight

Dashboards provide a centralized and visual way to monitor cloud environments, making it easier to detect anomalies and understand system behavior.

This implementation demonstrates how AWS CloudTrail logs can be transformed into actionable security insights using Splunk.

CloudTrail provides visibility into AWS API activity but does not capture OS-level events such as SSH access, highlighting a gap that would require additional monitoring solutions.
