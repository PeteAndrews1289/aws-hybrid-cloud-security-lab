# Evidence and Limitations

## Observed in the completed lab

- One VPC was divided into a public subnet and a private subnet.
- One public EC2 workload was reachable over HTTP; administrative SSH was restricted by source address.
- One private EC2 workload had no public IPv4 address and no direct route to the internet gateway.
- CloudTrail management events were stored in S3, retrieved locally, and imported into Splunk Enterprise.
- The retained Splunk sample contains 40 events. The most common action was `DescribeAlarms` with 16 events.
- Three scheduled Splunk alert concepts were configured: failed API calls, EC2 state changes, and security-group changes.
- One failed `GetInsightSelectors` call returned `InsightNotEnabledException`.

## Interpretation

The exercise demonstrates network-segmentation reasoning and a basic cloud-control-plane detection workflow. It does not establish production readiness, attack prevention, or high-fidelity anomaly detection. The sample is small and is best treated as implementation evidence rather than a statistical security study.

## Limitations

- Log ingestion was a manual batch workflow, not a real-time pipeline.
- The retained sample contains only 40 CloudTrail management events.
- CloudTrail does not provide host process, SSH session, or packet-level visibility.
- VPC Flow Logs, host telemetry, automated deployment, and detection tuning were outside the completed scope.
- Original screenshots contained account, network, and credential identifiers. They were removed from the current portfolio branch after the environment and credentials were decommissioned.

## Safer public evidence

The repository keeps aggregate Splunk charts, reusable SPL, setup notes, and a sanitized architecture summary. Raw CloudTrail events and infrastructure identifiers are intentionally withheld.
