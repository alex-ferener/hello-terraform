# Hello Terraform
This repository contains the infrastructure code necessary to run a hello world app on EKS.

### Infrastructure overview

For simplicity, the image contains only 2 availability zones, but the number of AZs is configurable in `tfvars`, 
and by default 3 AZs will be created.

Due to time constrains the following resources were not implemented: 
`Route 53`, `CloudFront`, `WAF`, `Certificate Manager`, `S3`

![diagram](https://github.com/alex-ferener/hello-terraform/blob/main/docs/diagram.png?raw=true)

### Assumptions
- The app is containerized (built and pushed to ECR) by a different system
- The helm chart is packaged and pushed to ECR by a different system
- The NAT Gateways were added to enable the app to make requests to external APIs

### Improvements
- The NAT Gateways could be replaced with VPC Endpoints / PrivateLink
- A Network Firewall could be added if domain filtering is required

### Prerequisites

Before provisioning the following tools needs to be installed:
- `terraform` >= `v1.1`
- `AWS CLI` >= `v2.4`
- `kubectl` >= `v1.21`
- `helm` >= `v3.8`

### Usage

To provision the infrastructure, run the following commands in `terraform` folder:

```shell
terraform init -backend-config=_prod.tfbackend
terraform plan -var-file=_prod.tfvars -out=tfplan
terraform apply tfplan
```

The provisioning will take approx 15 minutes, and at the end the output `elb_endpoint` 
will contain the app's endpoint. Use `curl` or a browser to test it.

### Clean-up

Because the ELB and its Security Group were created by EKS, they need to be manually removed.

After that, all resources created by terraform can be removed with the command:

```shell
terraform destroy -var-file=_prod.tfvars -auto-approve
```
