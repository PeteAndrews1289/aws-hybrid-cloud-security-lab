# Phase 2 - EC2 Deployment

## Goal
Deploy one public-facing EC2 instance and one private internal EC2 instance to support segmented cloud architecture.

## Planned Instances
- Public web server in public subnet
- Private internal server in private subnet

## Security Intent
- Public instance should allow HTTP access and restricted SSH administration
- Private instance should not be directly reachable from the internet


## Public EC2 Instance

Created a public-facing EC2 instance named HybridCloudLab-WebServer to simulate a basic internet-accessible web server.

Selected Amazon Linux AMI for ease of setup and common Linux server administration workflow. Used a small general-purpose instance type appropriate for low-cost lab testing.

Created a dedicated SSH key pair for administrative access to the public EC2 instance. Private key material was stored locally and excluded from version control.

Placed the web server in the public subnet and enabled automatic public IP assignment to allow external connectivity.

Configured a security group for the public web server allowing HTTP from any source and SSH only from my current public IP to reduce administrative exposure.

Initial SSH attempt failed due to misplaced private key location, upon moving it to its proper place was able to connect.

Successfully connected to the public EC2 instance via SSH using the project key pair. Verified that SSH access worked only after instance health checks completed and inbound rule matched my current IP.

Installed Apache HTTP Server on the public EC2 instance, enabled the service at boot, and deployed a simple landing page to verify internet-facing functionality.

Verified that the public EC2 instance served a webpage over HTTP from the internet, confirming correct subnet placement, route configuration, public IP assignment, and security group rules.


## Private EC2 Instance

Created a second EC2 instance named HybridCloudLab-InternalServer in the private subnet with public IP assignment disabled to simulate an internal-only workload.

Applied a dedicated security group to the private instance and avoided public inbound access to preserve internal-only placement.

Confirmed that the internal server did not receive a public IP address and was therefore not directly reachable from the public internet.

## Segmentation Validation

Verified expected architecture behavior:
- Public web server was reachable over HTTP
- Administrative SSH access to the public instance was restricted
- Private internal server had no direct internet exposure
