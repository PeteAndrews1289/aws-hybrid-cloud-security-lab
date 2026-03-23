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
