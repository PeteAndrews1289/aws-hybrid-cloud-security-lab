# Phase 1 - Network Setup

## Goal
Build a segmented network using AWS VPC with public and private subnets.

## Planned Components
- VPC with CIDR 10.0.0.0/16
- Public subnet (10.0.1.0/24)
- Private subnet (10.0.2.0/24)
- Internet Gateway
- Route tables

## Design Reasoning
- Public subnet will host internet-facing resources
- Private subnet will host internal resources
- Segmentation reduces attack surface and enforces security boundaries


## VPC Creation

Created VPC named HybridCloudLab-VPC with CIDR block 10.0.0.0/16.

This allows for up to 65,536 IP addresses and supports multiple subnet allocations for scalability and segmentation.
