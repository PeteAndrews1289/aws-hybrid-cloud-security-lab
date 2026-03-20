# Phase 2 - EC2 Deployment

## Goal
Deploy one public-facing EC2 instance and one private internal EC2 instance to support segmented cloud architecture.

## Planned Instances
- Public web server in public subnet
- Private internal server in private subnet

## Security Intent
- Public instance should allow HTTP access and restricted SSH administration
- Private instance should not be directly reachable from the internet
