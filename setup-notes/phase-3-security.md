# Phase 3 - Security Hardening

## Goal
Refine access controls and document security decisions across the AWS lab environment.

## Security Objectives
- Restrict administrative access
- Reduce unnecessary public exposure
- Preserve separation between public and private workloads
- Validate that access controls behave as intended

## Public Web Server Security

The public EC2 instance was placed in the public subnet to host an internet-accessible web server.

Security controls applied:
- HTTP (port 80) allowed from any source to support public access
- SSH (port 22) restricted to my public IP only
- Security group limited administrative exposure while preserving web functionality

## Private Internal Server Security

The internal EC2 instance was placed in the private subnet with public IP assignment disabled.

Security controls applied:
- No public IPv4 address assigned
- No inbound security group rules configured
- Private route table does not contain a direct route to the Internet Gateway


## Security Validation

Validated the following:
- Public web server was reachable over HTTP from the internet
- SSH access to the public host was restricted to my source IP
- Private instance was not directly reachable from the internet
- Route tables enforced intended public/private segmentation
These controls reduce attack surface and preserve internal-only placement.

