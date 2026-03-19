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


## Public Subnet

Created public subnet (10.0.1.0/24) for internet-facing resources such as web servers.

Assigned to a single availability zone for simplicity in initial lab setup.

## Private Subnet

Created private subnet (10.0.2.0/24) for internal resources.

This subnet will not have direct internet exposure, reducing attack surface.


## Internet Gateway

Created and attached an Internet Gateway to enable communication between the VPC and the public internet.

This is required for public subnet resources to be accessible externally.


## Public Route Table

Configured route table with default route (0.0.0.0/0) pointing to Internet Gateway.

Associated with public subnet to allow outbound and inbound internet traffic.


## Private Route Table

Configured route table without internet gateway route.

This ensures private subnet resources remain isolated from direct internet access.


## Public IP Assignment

Enabled auto-assign public IPv4 for public subnet to allow instances to be reachable from the internet.
