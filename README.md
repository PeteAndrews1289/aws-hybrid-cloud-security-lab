# aws-hybrid-cloud-security-lab
AWS lab


# Hybrid Cloud Security Lab (AWS)

## Objective
Design and deploy a secure AWS environment with segmented networking, monitored workloads, and simulated attack activity.

## Architecture Overview
- Custom VPC
- Public and private subnets
- Internet Gateway
- EC2 instances (public + private)
- Security groups
- CloudTrail and CloudWatch monitoring

## Security Goals
- Enforce network segmentation
- Apply least privilege principles
- Limit public exposure
- Monitor and log activity

## Planned Phases
1. Network setup (VPC, subnets, routing)
2. EC2 deployment
3. Security hardening
4. Monitoring setup
5. Attack simulation and analysis


## Evidence
Screenshots included in this repository show:
- VPC and subnet layout
- route table associations
- internet gateway attachment
- public and private EC2 placement
- public security group configuration
- successful public web server validation

## Security Design Decisions
- Restricted SSH access to the public EC2 instance by limiting port 22 to my public IP only
- Avoided assigning a public IP address to the internal EC2 instance
- Used separate public and private subnets to enforce segmentation
- Kept the private subnet isolated from direct internet routing

## Validation Performed
- Confirmed the public web server was accessible over HTTP
- Verified that the internal server was not directly exposed to the internet
- Confirmed security group and route table behavior matched intended design

## Monitoring and Logging
- Enabled AWS CloudTrail to capture API activity across the environment
- Reviewed CloudTrail event history to observe infrastructure actions
- Used CloudWatch to monitor EC2 metrics such as CPU and network activity
- Established baseline system behavior prior to attack simulation


## Security Gaps Identified

- No visibility into failed SSH login attempts
- No host-level logging configured
- No centralized log aggregation (SIEM)
- SSH exposed to the internet (even if restricted)

### Risk

An attacker could attempt repeated login attempts or exploit vulnerabilities without being detected by default AWS logging services.

## Security Recommendations

- Replace SSH with AWS Systems Manager Session Manager to eliminate public SSH exposure
- Enable host-level logging (e.g., auth logs)
- Integrate logs into a SIEM solution (e.g., Splunk)
- Enable VPC Flow Logs for network visibility
- Implement intrusion detection mechanisms for abnormal behavior

## Key Takeaway

This project demonstrates that cloud security is not just about restricting access, but also about ensuring sufficient visibility to detect and respond to malicious activity.



# Splunk SIEM Integration

## Process

- Generated AWS logs using CloudTrail
- Stored logs in S3
- Downloaded and extracted JSON log files
- Uploaded logs into Splunk Enterprise
- Parsed nested CloudTrail records using `spath` and `mvexpand`
- Built detection queries to analyze AWS activity

## Result

Created a working SIEM pipeline for analyzing AWS CloudTrail logs in Splunk.

## Insight

Splunk provides centralized visibility into AWS API activity, enabling detection of infrastructure changes, failed actions, and identity-based events.

CloudTrail logs required custom parsing due to nested JSON structure, demonstrating the importance of understanding log formats during SIEM integration.

CloudTrail does not capture OS-level activity, highlighting a key gap in cloud-native logging.


## Dashboard Visualization

## Process

- Built a Splunk dashboard to monitor AWS CloudTrail logs
- Created visual panels for API activity, EC2 events, failed actions, and time-based trends

## Result

Developed a SIEM-style dashboard that provides visibility into AWS service activity and potential security events.

## Insight

The dashboard enables quick identification of:

- Most common AWS API actions
- Infrastructure-related activity (EC2)
- Failed API calls
- Service activity trends over time

This demonstrates how raw CloudTrail logs can be converted into meaningful security visualizations using Splunk.

## SIEM Integration

This project was extended by integrating Splunk Enterprise to analyze AWS CloudTrail logs.

### Process

- Retrieved CloudTrail logs from Amazon S3
- Used AWS CLI to bulk download logs with `aws s3 sync`
- Uploaded logs into Splunk Enterprise
- Parsed nested CloudTrail records using `spath` and `mvexpand`
- Built detections, dashboards, and alerts for AWS activity

### Result

Successfully created a cloud security monitoring workflow using AWS CloudTrail and Splunk.

### Insight

This extended the project from an AWS infrastructure lab into a cloud security monitoring pipeline.

---

## Dashboard and Alerts

### Process

- Built Splunk dashboards for AWS API activity, EC2 activity, failed API calls, and service activity over time
- Created alerts for failed API calls, EC2 state changes, and security group changes

### Result

Added visual monitoring and detection capability to the cloud environment.

### Insight

Dashboards and alerts make AWS activity easier to interpret and move the project closer to a real cloud security workflow.

---

## Automation

### Process

- Configured AWS CLI using IAM programmatic access
- Used `aws s3 sync` to bulk retrieve CloudTrail logs from S3

### Result

Improved the scalability of the log collection process.

### Insight

Automating log retrieval reflects a more realistic cloud engineering workflow than manual downloads.

---

## Key Security Insights

- CloudTrail provides strong visibility into AWS API activity
- Splunk enables centralized analysis, dashboards, and alerts
- Change-based events such as EC2 lifecycle actions and security group modifications provide stronger security value than read-only API calls
- CloudTrail does not capture OS-level events such as SSH sessions or shell commands
