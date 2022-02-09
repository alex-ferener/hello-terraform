# Hello Terraform
This repository contains the infrastructure code necessary to run a hello world app on EKS.

### Infrastructure overview

For simplicity, the image contains only 2 availability zones, but the number of AZs is configurable in `tfvars`,
and by default 3 AZs will be created.

Due to time constrains the following resources were not implemented:<br/>
`Route 53`, `CloudFront`, `WAF`, `Certificate Manager`, `S3`, `Aurora`

![diagram](https://github.com/alex-ferener/hello-terraform/blob/main/docs/diagram.png?raw=true)

### Assumptions
- The app is containerized (built and pushed to `ECR`) by a different system
- The helm chart is packaged and pushed to `ECR` by a different system
- Created own terraform modules instead of using the community ones.
  This makes things more flexible, but has an extra cost (maintenance).
- The `NAT Gateways` were added to enable the app to make requests to external APIs
- `CloudFront` was added to improve latency (plus the other benefits a CDN brings,
  but this comes with additional costs)
- `EKS nodes` can be accessed with `SSM Session Manager`
- `S3` can be accessed privately with `Gateway VPC endpoints`
- `WAF` was added to enable web traffic filtering
- High availability is achieved using multiple AZs and pod anti affinity

### Prerequisites

The following tools are required:
- `terraform` >= `v1.1`
- `AWS CLI` >= `v2.4`
- `kubectl` >= `v1.21`
- `helm` >= `v3.8`

### Usage

To provision the infrastructure, run the following commands in `terraform` folder:

```shell
terraform init
terraform plan -var-file=_prod.tfvars -out=tfplan
terraform apply tfplan
```

The provisioning will take approx 15 minutes, and at the end the output `elb_endpoint`
will contain the app's endpoint. Use `curl` or a browser to test it.

### AWS Resources

Terraform will create the following resources:
- `VPC`
- `Internet Gateway`
- `Subnets` (`Public` / `Private` / `Isolated`)
- `Routing tables`
- `NAT Gateways` + `Elastic IPs`
- `Gateway VPC endpoint` for `S3` 
- `IAM Roles`
- `EKS Cluster`
- `EKS Managed Nodegroup`
- `IAM OIDC provider` (used by `EKS`)

### Further Improvements
- Install `AWS Load Balancer Controller` and use it as an `ingress controller`. The current setup uses
  an inefficient solution (`Service` -> `Type: LoadBalancer`)
- To improve security the `NAT Gateways` could be replaced with `VPC Endpoints` / `PrivateLink`
- A `Network Firewall` could be added if domain whitelisting (for 3rd party APIs) is required
- Add `IAM Roles for Service Account`
- Deploy `security groups for pods`
- Install `EKS Addons`: `CoreDNS`, `kube-proxy` and `vpc-cni`
- Install `AWS Secrets and Configuration Provider` (ASCP)
- Install `cluster-autoscaler`
- Run the app as `non-root` user and drop `ALL capabilities`

### Clean-up

Because the `ELB` and its `Security Group` were created by `EKS`, they need to be manually removed.

An alternative way of removing them is to uninstall the chart:

```shell
helm uninstall hello
```

After that, all resources created by terraform can be removed with the command below:

```shell
terraform destroy -var-file=_prod.tfvars -auto-approve
```
