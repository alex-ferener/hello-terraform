# vpc module

The module will create:
- VPC
- Internet Gateway
- NAT Gateways (one for each public AZ) + Elastic IPs
- S3 VPC Endpoint (Gateway)
- Subnets (Public / Private / Isolated)
- Route Tables & Routes
